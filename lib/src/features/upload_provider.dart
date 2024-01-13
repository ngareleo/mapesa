import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:mapesa/src/features/cache/common_cache.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transactions/transaction.dart';

// module for uploading transactions

class TransactionsUploadProvider {
  static final _dio = Dio();
  static int? lastUploadedMessageId;
  static const lastUploadedMessageKey = "last_message_id";

  TransactionsUploadProvider() {
    _loadLastMessageIdFromStorage();
    _dio.options
      ..baseUrl = CommonCache.backendURLCache.value
      ..connectTimeout = const Duration(minutes: 2);
  }

  Future<bool> uploadTransactions(List<Transaction?> transactions) async {
    try {
      await _dio.post("/upload/transactions",
          data: {
            "transactions": transactions
                .map((transaction) => transaction?.toJson())
                .toList()
          },
          onSendProgress: (int sent, int total) {});
    } on DioException catch (e) {
      return false;
    }

    return true;
  }

  Future<List<Transaction?>> fetchTransactions() async {
    var messages = (await SMSProvider.instance
        .fetchRecentMessages(fromId: lastUploadedMessageId ?? 0));

    var data = messages.map((msg) => msg.body).toList();

    debugPrint("Messages : ${data.toString()}");
    return [];
  }

  void _loadLastMessageIdFromStorage() async {
    var prefs = await SharedPreferences.getInstance();
    lastUploadedMessageId = prefs.getInt(lastUploadedMessageKey);
  }

  void _setLastUploadedMessageId(int id) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastUploadedMessageKey, id);
  }
}
