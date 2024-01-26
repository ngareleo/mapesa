import 'package:dio/dio.dart';

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

class UploadResponse {
  UploadStatus status;
  ListOfObjects failed;

  UploadResponse({this.status = UploadStatus.unknown, this.failed = const []});
}

typedef UploadResponseType = Future<(UploadStatus, bool)>;

class TransactionsUploadProvider {
  static final _dio = DioProvider.instance.dio;

  Future<UploadResponse> _uploadSingleDPayload(
      MultipleTransactions payload) async {
    Response? response;

    try {
      response = await _dio.post(
        "/upload/transactions",
        data: {"raw": payload},
      );
    } on DioException catch (e) {
      var errResponse = e.response;
      if (errResponse?.statusCode == 400) {
        return UploadResponse(
            status: UploadStatus.success, failed: errResponse?.data["failed"]);
      } else if (errResponse?.statusCode == 500) {
        return UploadResponse(status: UploadStatus.internalServerError);
      }
    }

    if (response?.statusCode == 200) {
      var failed = response?.data["failed"] as ListOfObjects;
      return UploadResponse(status: UploadStatus.success, failed: failed);
    }

    return UploadResponse(status: UploadStatus.unknown);
  }

  Future<UploadResponse> uploadTransactions(
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
      return UploadResponse(status: UploadStatus.nothingToUpload);
    }

    var dPayload = _splitTransactionsTo2D(transactions);

    // what happens if a single payload fails?
    // we store the payload in a local db then try to upload it later
    var res = await Future.wait(
        dPayload.map((payload) => _uploadSingleDPayload(payload)));

    return res.reduce((value, element) {
      // if any of the payloads failed, we return the failed transactions
      // if any passes we returned the failed transactions and a success
      var UploadResponse(:status, :failed) = value;
      value.status = status == UploadStatus.success ? status : element.status;
      value.failed.addAll(failed);
      return value;
    });
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
