import 'dart:isolate';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/features/upload_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

class UTDProvider {
  // Keeps transactions server side [u]p [t]o [d]ate.
  // Generally this is a service that runs in the background

  static final mapper = TransactionsMapper();

  static int? lastUploadedMessageId;
  static const lastUploadedMessageKey = "last_message_id";
  static final transactionUploadProvider = TransactionsUploadProvider();

  UTDProvider() {
    _loadLastMessageIdFromStorage();
  }

  Future<MultipleTransactions> fetchTransactions() async {
    var messages = (await SMSProvider.instance
        .fetchRecentMessages(fromId: lastUploadedMessageId ?? 0));
    var transactions = <Transaction>[];
    for (var msg in messages) {
      var transaction = mapper.mapFromAToB(msg);
      if (transaction != null) {
        transactions.add(transaction);
      }
    }
    return transactions;
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

  Future<MultipleTransactions> refresh() async {
    var transactions = await fetchTransactions();
    return transactions;
  }

  Future<List<dynamic>> uploadTransactions(
      List<Transaction> transactions) async {
    var (status, data) = await Isolate.run(
        () => transactionUploadProvider.uploadTransactions(transactions));
  }
}
