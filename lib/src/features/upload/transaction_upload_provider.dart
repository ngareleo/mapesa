import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:mapesa/src/features/dio_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/utils/common.dart';

import 'types.dart';

// module for uploading transactions

class TransactionsUploadProvider {
  static const payloadSize = 300;

  Future<SinglePayloadUploadResponse> _uploadSingleDPayload(
      MultipleTransactions payload) async {
    var dio = DioProvider.instance.dio;
    Response? response;
    var pay = payload.map((e) => e.toJson()).toList();

    try {
      response = await dio.post(
        "/upload/transactions",
        data: {"raw": pay},
        onSendProgress: (sent, total) {
          debugPrint("Sent: $sent, Total: $total");
        },
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
      debugPrint(response.data.toString());
      var oks = mapListOfObjects(response.data["oks"]);
      var duplicates = mapListOfObjects(response.data["duplicates"]);
      var failed = mapListOfObjects(response.data["failed"]);
      return SinglePayloadUploadResponse(
          status: SingleUploadStatusType.success,
          oks: oks,
          duplicates: duplicates,
          failed: failed);
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
    // 4. An error occurs before response is received

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
      var BatchUpload(:duplicates, :failed, :oks) = totalResponse;
      totalResponse = BatchUpload(
        duplicates: duplicates + element.duplicates,
        failed: failed + element.failed,
        oks: oks + element.oks,
      );
    }

    return totalResponse;
  }

  List<MultipleTransactions> _splitTransactionsTo2D(
      List<Transaction> transactions) {
    // split transactions into 2D array of 1000 transactions each
    var dPayload = <MultipleTransactions>[];
    var end = transactions.length;

    if (transactions.length <= payloadSize) {
      dPayload.add(transactions);
      return dPayload;
    }
    for (var i = 0; i < (transactions.length / payloadSize) + 1; i++) {
      if ((i + 1) * payloadSize > end) {
        dPayload.add(transactions.sublist(i * payloadSize, end));
        break;
      }
      dPayload
          .add(transactions.sublist(i * payloadSize, (i + 1) * payloadSize));
    }
    return dPayload;
  }
}
