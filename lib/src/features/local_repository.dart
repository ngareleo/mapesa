import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapesa/src/features/shared_preferences_keystore.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:telephony/telephony.dart';

enum RefreshStatus { permissionDenied, success }

// Makes sure all messages are persisted to local store
class LocalRepository extends ChangeNotifier {
  static final _lastUploadedMessageKey =
      SharedPreferencesKeyStore.authProvider.value;
  final SMSProvider _smsProvider = SMSProvider.instance;
  final Isar _isar;
  final SharedPreferences _prefs;
  static LocalRepository? _instance;

  static Future<void> init(Isar isar) async {
    if (_instance != null) {
      throw Exception("SimpleLocalRepository already exists");
    }
    final prefs = await SharedPreferences.getInstance();
    _instance = LocalRepository._(isar, prefs);
  }

  LocalRepository._(this._isar, this._prefs);

  static LocalRepository get instance {
    if (_instance == null) {
      throw Exception("SimpleLocalRepository not initialized");
    }
    return _instance!;
  }

  int? get lastUploadedMessageId {
    return _prefs.getInt(_lastUploadedMessageKey);
  }

  bool isFirstLoad() {
    return lastUploadedMessageId == null;
  }

  Future<List<CompactTransaction>> getMessagesFromLast3Months(
      {int limit = 10}) async {
    final messages = await _isar.compactTransactions
        .where()
        .dateTimeLessThan(DateTime.now().subtract(const Duration(days: 90)))
        .limit(limit)
        .findAll();
    return messages;
  }

  Future<RefreshStatus> refresh() async {
    final mapper = TransactionsMapper();
    List<SmsMessage> messages = [];

    try {
      final m = await _smsProvider.fetchMessages(fromId: lastUploadedMessageId);
      messages.addAll(m);
    } catch (e) {
      return RefreshStatus.permissionDenied;
    }

    final compactTransactions = messages
        .map((m) => mapper.mapFromAToB(m)?.toCompactTransaction())
        .whereType<CompactTransaction>()
        .toList();

    await _isar.writeTxn(() async {
      await _isar.compactTransactions.putAll(compactTransactions);
    });

    final latestId =
        (await _isar.compactTransactions.where().findFirst())?.messageId;
    if (latestId != null) {
      await _prefs.setInt(_lastUploadedMessageKey, latestId);
    }

    notifyListeners();
    return RefreshStatus.success;
  }
}
