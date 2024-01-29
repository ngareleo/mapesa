import 'package:cron/cron.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapesa/src/features/repository/failed_transactions.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/features/upload/transaction_upload_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

import 'upload/types.dart';

enum UTDStatus { idle, busy }

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

  UTDStatus status = UTDStatus.idle;

  static Future<void> init() async {
    /// Called in the main function to initialize the provider and perform aync tasks
    if (_instance != null) {
      throw Exception("UTDProvider already initialized");
    }
    _instance = UTDProvider._();
    _instance!._retryFailedTransactions();
    await _instance!._loadLastMessageIdFromStorage();
    debugPrint("UTDProvider initialized");
  }

  UTDProvider._();

  static UTDProvider get instance {
    if (_instance == null) {
      throw Exception("UTDProvider not initialized. Call UTDProvider.init()");
    }
    return _instance!;
  }

  Future<MultipleTransactions> fetchTransactions() async {
    debugPrint("Last message ID: $_lastUploadedMessageId");
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

  Future<void> refresh() async {
    if (status == UTDStatus.busy) {
      debugPrint("UTDProvider is busy");
      return;
    }
    var transactions = await fetchTransactions();
    await uploadTransactions(transactions);
  }

  Future<void> uploadTransactions(List<Transaction> transactions,
      {bool overrideLastMessageID = true}) async {
    // TODO: Add limit for failed transactions

    if (transactions.isEmpty) {
      debugPrint("No transactions to upload");
      return;
    }
    status = UTDStatus.busy;
    transactions.sort(
      (a, b) => a.messageId.compareTo(b.messageId),
    );
    var res = await _transactionUploadProvider.uploadTransactions(transactions);

    debugPrint("UTDProvider uploadTransactions: $res");

    switch (res.status) {
      case BatchUploadStatusType.success:
        if (!overrideLastMessageID) break;
        await _setLastUploadedMessageId(transactions.last.messageId);
        break;
      case BatchUploadStatusType.partial:
        // Some transactions have been uploaded successfully
        // Save the failed transactions and try again later
        if (res.failed.isNotEmpty) {
          await FailedTransactionsRepository.instance
              .saveFailedTransactions(res.failed);
        }
        _scheduleFailedTransactionsUpload();
        await _setLastUploadedMessageId(transactions.last.messageId);
        break;
      case BatchUploadStatusType.fail:
        // Nothing we can do but try again later from the previous message ID
        break;
      case BatchUploadStatusType.nothingToUpload:
        await FailedTransactionsRepository.instance
            .saveFailedTransactions(res.failed);
        break;
    }
    status = UTDStatus.idle;
  }

  void _retryFailedTransactions() async {
    var fromServerSideT =
        await FailedTransactionsRepository.instance.fetchFailedTransactions();
    ServerSideTModelMapper mapper = ServerSideTModelMapper();
    var failedTransactions = fromServerSideT
        .map((failedTransaction) => mapper.mapFromAToB(failedTransaction)!)
        .toList();
    if (failedTransactions.isEmpty) return;
    await uploadTransactions(failedTransactions, overrideLastMessageID: false);
  }

  Future<void> _loadLastMessageIdFromStorage() async {
    var prefs = await SharedPreferences.getInstance();
    _lastUploadedMessageId = prefs.getInt(_lastUploadedMessageKey);
  }

  Future<void> _setLastUploadedMessageId(int id) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastUploadedMessageKey, id);
    _lastUploadedMessageId = id;
  }

  void _scheduleFailedTransactionsUpload() {
    _cron.schedule(_after30Minutes, () => _retryFailedTransactions());
  }

  static void nullCheck() {
    assert(_instance != null, true);
    debugPrint("UTDProvider null check");
  }
}
