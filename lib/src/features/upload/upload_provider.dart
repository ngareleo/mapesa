import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:mapesa/src/features/dio_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

import 'types.dart';

// module for uploading transactions

class TransactionsUploadProvider {
  static final _dio = DioProvider.instance.dio;

  Future<SinglePayloadUploadResponse> _uploadSingleDPayload(
      MultipleTransactions payload) async {
    Response? response;
    var pay = payload.map((e) => e.toJson() as Map<String, String>).toList();

    try {
      response = await _dio.post(
        "/upload/transactions",
        data: {"raw": pay},
      );
    } on DioException catch (e) {
      var errResponse = e.response;
      if (errResponse?.statusCode == 400) {
        // Means we screwed up with the payload
        debugPrint("Payload is invalid:: $pay");
        return SinglePayloadUploadResponse(
            status: SingleUploadStatusType.clientSideError, failed: pay);
      }
      return SinglePayloadUploadResponse(
          status: SingleUploadStatusType.serverSideError, failed: pay);
    }

    if (response.statusCode == 200) {
      var duplicates = response.data["failed"];
      var unknowns = response.data["unknown"];
      return SinglePayloadUploadResponse(
          status: SingleUploadStatusType.success,
          duplicates: duplicates,
          failed: unknowns);
    }

    return SinglePayloadUploadResponse(
        status: SingleUploadStatusType.unknown, failed: pay);
  }

  Future<BatchUpload> uploadTransactions(
    List<Transaction> transactions,
  ) async {
    // Generally there will be three results after uploading
    // 1. [Complete] All transactions are uploaded successfully.
    //    All requests return 200 but there are failed transactions, maybe due to duplicate transactions
    //
    // 2. [Parital] Some transactions are uploaded successfully
    //    Some requests return 200 but there are failed transactions, maybe 500
    //
    // 3. [Fail] No transactions are uploaded successfully
    //    All requests return 500
    // -----------------------------------------------------
    // 4. An error occurs

    if (transactions.isEmpty) {
      return BatchUpload(status: BatchUploadStatusType.nothingToUpload);
    }

    var dPayload = _splitTransactionsTo2D(transactions);

    // what happens if a single payload fails?
    // we store the payload in a local db then try to upload it later
    var res = await Future.wait(
        dPayload.map((payload) => _uploadSingleDPayload(payload)));

    var totalResponse = BatchUpload(
      status:
          res.any((element) => element.status == SingleUploadStatusType.success)
              ? BatchUploadStatusType.partial
              : BatchUploadStatusType.fail,
    );

    if (totalResponse.status == BatchUploadStatusType.fail) {
      // no need to try recover, we'll just retry later
      return totalResponse;
    }

    for (var element in res) {
      totalResponse.duplicates.addAll(element.duplicates);
      totalResponse.failed.addAll(element.failed);
    }

    return totalResponse;
  }

  List<MultipleTransactions> _splitTransactionsTo2D(
      List<Transaction> transactions) {
    // split transactions into 2D array of 1000 transactions each
    const dPayload = <MultipleTransactions>[];
    for (var i = 0; i < (transactions.length / 1000) + 1; i++) {
      dPayload.add(transactions.sublist(i * 1000, (i + 1) * 1000));
    }
    return dPayload;
  }
}
