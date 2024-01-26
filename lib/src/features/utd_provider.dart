import 'dart:isolate';
import 'package:cron/cron.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapesa/src/features/repository/failed_transactions.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/features/upload_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

class UTDProvider {
  // Keeps transactions server side [u]p [t]o [d]ate.
  // Generally this is a service that runs in the background
  static UTDProvider? _instance;
  static const _lastUploadedMessageKey = "last_message_id";
  static final _after30Minutes = Schedule(minutes: 30);

  final _mapper = TransactionsMapper();
  int? _lastUploadedMessageId;
  final _transactionUploadProvider = TransactionsUploadProvider();
  final _cron = Cron();

  UTDProvider._() {
    _loadLastMessageIdFromStorage();
  }

  static UTDProvider get instance => _instance ?? UTDProvider._();

  Future<MultipleTransactions> fetchTransactions() async {
    var messages = (await SMSProvider.instance
        .fetchRecentMessages(fromId: _lastUploadedMessageId ?? 0));
    var transactions = <Transaction>[];
    for (var msg in messages) {
      var transaction = _mapper.mapFromAToB(msg);
      if (transaction != null) {
        transactions.add(transaction);
      }
    }
    return transactions;
  }

  void _loadLastMessageIdFromStorage() async {
    var prefs = await SharedPreferences.getInstance();
    _lastUploadedMessageId = prefs.getInt(_lastUploadedMessageKey);
  }

  Future<void> _setLastUploadedMessageId(int id) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastUploadedMessageKey, id);
    _lastUploadedMessageId = id;
  }

  Future<MultipleTransactions> refresh() async {
    var transactions = await fetchTransactions();
    return transactions;
  }

  Future<void> uploadTransactions(List<Transaction> transactions) async {
    // TODO: Add limit for failed transactions
    // TODO: Handle all return cases

    transactions.sort((a, b) => a.messageId.compareTo(b.messageId));
    var res = await Isolate.run(
        () => _transactionUploadProvider.uploadTransactions(transactions));

    if (res.failed.isNotEmpty) {
      await FailedTransactionsRepository.instance
          .saveFailedTransactions(res.failed);
    }

    if (res.status == UploadStatus.success) {
      await _setLastUploadedMessageId(transactions.last.messageId);
    }

    _cron.schedule(_after30Minutes, () => scheduleFailedTransactionsUpload());
  }

  Future<void> scheduleFailedTransactionsUpload() async {
    var fromServerSideT =
        await FailedTransactionsRepository.instance.fetchFailedTransactions();
    ServerSideTModelMapper mapper = ServerSideTModelMapper();
    var failedTransactions = fromServerSideT
        .map((failedTransaction) => mapper.mapFromAToB(failedTransaction)!)
        .toList();
    if (failedTransactions.isEmpty) return;

    if (failedTransactions.isNotEmpty) {
      var res = await Isolate.run(() =>
          _transactionUploadProvider.uploadTransactions(failedTransactions));

      if (res.status == UploadStatus.success) {
        await FailedTransactionsRepository.instance
            .deleteAllFailedTransactions();
      }

      if (res.failed.isNotEmpty) {
        await FailedTransactionsRepository.instance
            .saveFailedTransactions(res.failed);
      }
    }
  }
}
