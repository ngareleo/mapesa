import 'package:dio/dio.dart';

import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/features/cache/common_cache.dart';
import 'package:mapesa/src/features/dio_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/types.dart';

// module for uploading transactions

enum UploadStatus {
  success,
  internalServerError,
  nothingToUpload,
  unknown,
}

typedef UploadResponse = Future<(UploadStatus, bool)>;

class TransactionsUploadProvider {
  static final _dio = DioProvider.instance.dio;

  TransactionsUploadProvider() {
    _dio.options
      ..baseUrl = CommonCache.backendURLCache.value
      ..connectTimeout = const Duration(minutes: 2)
      ..headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${AuthProvider.authToken}"
      };
  }

  UploadResponse _uploadSingleDPayload(MultipleTransactions payload) async {
    Response? response;
    try {
      response = await _dio.post(
        "/upload/transactions",
        data: {"raw": payload},
      );
    } on DioException catch (e) {
      var response = e.response;
      if (response?.statusCode == 400) {
        return (UploadStatus.internalServerError, false);
      } else if (e.response?.statusCode == 500) {
        return (UploadStatus.internalServerError, false);
      }
    }

    if (response?.statusCode == 200) {
      var failed = response?.data["failed"] as ListOfObjects;
      return (UploadStatus.success, true);
    }

    return response?.statusCode != 200
        ? (UploadStatus.unknown, false)
        : (UploadStatus.success, true);
  }

  UploadResponse uploadTransactions(
    List<Transaction> transactions,
  ) async {
    if (transactions.isEmpty) {
      return (UploadStatus.nothingToUpload, false);
    }

    var dPayload = _splitTransactionsTo2D(transactions);

    // what happens if a single payload fails?
    // we store the payload in a local db then try to upload it later
    var data = await Future.wait(
        dPayload.map((payload) => _uploadSingleDPayload(payload)));
  }

  List<MultipleTransactions> _splitTransactionsTo2D(
      List<Transaction> transactions) {
    const dPayload = <MultipleTransactions>[];
    for (var i = 0; i < (transactions.length / 1000) + 1; i++) {
      dPayload.add(transactions.sublist(i * 1000, (i + 1) * 1000));
    }
    return dPayload;
  }
}
