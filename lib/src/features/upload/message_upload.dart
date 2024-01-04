import 'dart:core';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapesa/src/features/upload/upload_services.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../message_handler.dart';
import 'mapper.dart';

class UploadService {
  // get the messages
  final MessageHandler messageHandler = MessageHandler();
  final Mapper mapper = Mapper();
  final uploadService = DioUploadService(uploadEndPoint: "");

  Future<List<Transaction?>> getTransactions() async {
    var prefs = await SharedPreferences.getInstance();
    var latestID = prefs.getInt("latest_id") ?? 0;
    var messages = await messageHandler.fetchMessages(latestID: latestID);
    if (messages.isEmpty) {
      return [];
    }
    var transactions = [
      for (var message in messages)
        mapper.mapMessageToTransaction(
            message: message.body, messageID: message.id)
    ];
    transactions.removeWhere((transaction) => transaction == null);
    return transactions;
  }

  Future<void> uploadMessages() async {
    var transactions = await getTransactions();
    if (transactions.isEmpty) {
      Fluttertoast.showToast(
        msg: "Up to date!",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    var hasUploadedSuccessfully =
        await uploadService.uploadTransactions(transactions);

    hasUploadedSuccessfully
        ? Fluttertoast.showToast(
            msg: "Transactions uploaded to Firebase successfully",
            toastLength: Toast.LENGTH_LONG,
          )
        : Fluttertoast.showToast(
            msg: "Transactions upload to Firebase failed",
            toastLength: Toast.LENGTH_LONG,
          );
  }

  void showUploadStatus({required bool hasUploaded}) {
    if (hasUploaded) {
      Fluttertoast.showToast(
        msg: "Uploaded",
        toastLength: Toast.LENGTH_LONG,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Failed",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
