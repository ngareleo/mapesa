import 'package:cron/cron.dart';
import 'package:flutter/foundation.dart';
import 'package:mapesa/src/features/shared_preferences_keystore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapesa/src/features/failed_transactions_repository.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/features/upload/transaction_upload_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

import 'upload/types.dart';

enum UTDStatus { idle, busy }

class RemoteServiceProvider extends ChangeNotifier {
  // Keeps transactions server side up2 date
  final SharedPreferences _prefs;
  static RemoteServiceProvider? _instance;
  static final _lastUploadedMessageKey =
      SharedPreferencesKeyStore.mobileServerReconciliation.value;
  static final _after30Minutes = Schedule(minutes: 30);
  final _mapper = TransactionsMapper();
  final _transactionUploadProvider = TransactionsUploadProvider();
  final _cron = Cron();

  int? get lastUploadedMessageId {
    return _prefs.getInt(_lastUploadedMessageKey);
  }

  static Future<void> init() async {
    /// Called in the main function to initialize the provider and perform async tasks
    if (_instance != null) {
      throw Exception("MobileServerReconciliationProvider already initialized");
    }
    final prefs = await SharedPreferences.getInstance();
    _instance = RemoteServiceProvider._(prefs);
    debugPrint("MobileServerReconciliationProvider initialized");
  }

  RemoteServiceProvider._(this._prefs);

  static RemoteServiceProvider get instance {
    if (_instance == null) {
      throw Exception("UTDProvider not initialized. Call UTDProvider.init()");
    }
    return _instance!;
  }

  Future<MultipleTransactions> fetchTransactionsFromLocalStorage() async {
    final messages = (await SMSProvider.instance
        .fetchMessages(fromId: lastUploadedMessageId ?? 0));
    return messages
        .map((msg) => _mapper.mapFromAToB(msg))
        .whereType<Transaction>()
        .toList();
  }

  Future<void> refresh() async {
    var transactions = await fetchTransactionsFromLocalStorage();
    await uploadTransactions(transactions);
  }

  Future<void> uploadTransactionsInSingleLoad(
    List<Transaction> transactions,
  ) async {
    if (transactions.isEmpty) {
      debugPrint("No transactions to upload");
      return;
    }
    transactions.sort((a, b) => a.messageId.compareTo(b.messageId));
    final response = await _transactionUploadProvider
        .uploadTransactionsInSinglePayload(transactions);
    switch (response.status) {
      case SingleUploadStatusType.success:
        await _setLastUploadedMessageId(transactions.last.messageId);
        break;
      case SingleUploadStatusType.nothingToUpload:
        debugPrint("We had nothing to upload");
      default:
        break;
    }
  }

  Future<void> uploadTransactions(List<Transaction> transactions,
      {bool overrideLastMessageID = true}) async {
    // TODO: Add limit for failed transactions
    if (transactions.isEmpty) {
      debugPrint("No transactions to upload");
      return;
    }
    transactions.sort(
      (a, b) => a.messageId.compareTo(b.messageId),
    );
    final res = await _transactionUploadProvider
        .uploadTransactionsInSplitPayloads(transactions);
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
  }

  Future<void> _retryFailedTransactions() async {
    final messages =
        await FailedTransactionsRepository.instance.fetchFailedTransactions();
    final mapper = CompactTransactionsMapper();
    if (messages.isEmpty) {
      return;
    }
    var failedTransactions = messages
        .map((ft) => mapper.mapFromAToB(ft))
        .whereType<Transaction>()
        .toList();
    await uploadTransactions(failedTransactions, overrideLastMessageID: false);
  }

  Future<void> _setLastUploadedMessageId(int id) async {
    await _prefs.setInt(_lastUploadedMessageKey, id);
  }

  void _scheduleFailedTransactionsUpload() {
    _cron.schedule(_after30Minutes, () => _retryFailedTransactions());
  }

  static void nullCheck() {
    assert(_instance != null, true);
    debugPrint("UTDProvider null check");
  }
}
