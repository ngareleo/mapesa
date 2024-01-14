import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:mapesa/src/features/cache/common_cache.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transactions/transaction.dart';

// module for uploading transactions

enum UploadStatus {
  success,
  internalServerError,
  nothingToUpload,
  unknown,
}

class TransactionsUploadProvider {
  static final mapper = TransactionsMapper();
  static final _dio = Dio();
  static int? lastUploadedMessageId;
  static const lastUploadedMessageKey = "last_message_id";

  TransactionsUploadProvider() {
    _loadLastMessageIdFromStorage();
    _dio.options
      ..baseUrl = CommonCache.backendURLCache.value
      ..connectTimeout = const Duration(minutes: 2)
      ..contentType = Headers.jsonContentType;
  }

  Future<(UploadStatus, bool)> uploadTransactions() async {
    var transactions = await fetchTransactions();
    transactions.removeWhere((t) => t == null);
    if (transactions.isEmpty) {
      return (UploadStatus.nothingToUpload, false);
    }

    Response? response;
    try {
      response = await _dio.post("/upload/transactions",
          data: {"raw": transactions.map((t) => t?.toJson()).toList()},
          onSendProgress: (int sent, int total) {});
    } on DioException catch (e) {
      var response = e.response;
      debugPrint("[E: ${response?.statusCode}] : ${response?.data}");
      if (response?.statusCode == 400) {
        // TODO: Handle this case.
        return (UploadStatus.internalServerError, false);
      } else if (e.response?.statusCode == 500) {
        // TODO: Handle this case.
        return (UploadStatus.internalServerError, false);
      }
    }

    if (response?.statusCode != 200) {
      return (UploadStatus.unknown, false);
    }

    debugPrint("[I: ${response?.statusCode}] : ${response?.data}");

    return (UploadStatus.success, true);
  }

  Future<List<Transaction?>> fetchTransactions() async {
    var messages = (await SMSProvider.instance
        .fetchRecentMessages(fromId: lastUploadedMessageId ?? 0));
    return messages.map((msg) => mapper.mapFromAToB(msg)).toList();
  }

  void _loadLastMessageIdFromStorage() async {
    var prefs = await SharedPreferences.getInstance();
    lastUploadedMessageId = prefs.getInt(lastUploadedMessageKey);
  }

  Future<void> _setLastUploadedMessageId(int id) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastUploadedMessageKey, id);
    lastUploadedMessageId = id;
  }
}
