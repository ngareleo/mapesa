import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/transactions/transaction.dart' as mpesa_transaction;

class DioUploadService {
  final dio = Dio();
  final String uploadEndPoint;

  DioUploadService({required this.uploadEndPoint}) {
    dio.options
      ..baseUrl = uploadEndPoint
      ..connectTimeout = 100000;

    dio.interceptors.add(InterceptorsWrapper(onError: (DioError e, handler) {
      Fluttertoast.showToast(
        msg: "Error uploading messages",
        toastLength: Toast.LENGTH_LONG,
      );
      return handler.next(e);
    }));
  }

  Future<bool> uploadTransactions(
      List<mpesa_transaction.Transaction?> transactions) async {
    try {
      await dio.post("/upload",
          data: {
            "transactions": transactions
                .map((transaction) => transaction?.toJson())
                .toList()
          },
          onSendProgress: (int sent, int total) {});
    } catch (error) {
      return false;
    }
    return true;
  }
}
