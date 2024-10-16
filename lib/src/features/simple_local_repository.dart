import 'package:isar/isar.dart';
import 'package:mapesa/src/features/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';

// Makes sure all messages are persisted to local store
class SimpleLocalRepository {
  static final _lastUploadedMessageKey =
      SharedPreferencesKeyStore.authProvider.value;

  final Isar _isar;
  final SMSProvider _smsProvider = SMSProvider.instance;
  static SimpleLocalRepository? _instance;
  static int? _lastUploadedMessageId;

  static Future<void> init(Isar isar) async {
    if (_instance != null) {
      throw Exception("SimpleLocalRepository already exists");
    }
    _instance = SimpleLocalRepository._(isar);
    await _instance!._loadLastMessageIdFromStorage();
  }

  SimpleLocalRepository._(this._isar);

  static SimpleLocalRepository get instance {
    if (_instance == null) {
      throw Exception("SimpleLocalRepository not initialized");
    }
    return _instance!;
  }

  Future<bool> isFirstLoad() async {
    await _loadLastMessageIdFromStorage();
    return _lastUploadedMessageId == 0;
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

  Future<void> refresh() async {
    final mapper = TransactionsMapper();
    final messages =
        await _smsProvider.fetchMessages(fromId: _lastUploadedMessageId);
    var compactTransactions = messages
        .map((m) => mapper.mapFromAToB(m)?.toCompactTransaction())
        .whereType<CompactTransaction>()
        .toList();

    await _isar.writeTxn(() async {
      await _isar.compactTransactions.putAll(compactTransactions);
    });

    final latestId =
        (await _isar.compactTransactions.where().findFirst())?.messageId;
    if (latestId != null) {
      _setLastUploadedMessageId(latestId);
    }
  }

  Future<void> _loadLastMessageIdFromStorage() async {
    var prefs = await SharedPreferences.getInstance();
    var key = prefs.getInt(_lastUploadedMessageKey);
    _lastUploadedMessageId = key ?? 0;
  }

  Future<void> _setLastUploadedMessageId(int id) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastUploadedMessageKey, id);
    _lastUploadedMessageId = id;
  }
}
