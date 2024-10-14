import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/repository/compact_transactions.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Makes sure all messages are persisted to local store
class SimpleLocalRepository {
  static const _lastUploadedMessageKey = "simple_local_repo_last_message_id";
  final CompactTransactionsRepository _repository =
      CompactTransactionsRepository.instance;
  final SMSProvider _smsProvider = SMSProvider.instance;
  static SimpleLocalRepository? _instance;
  static late int? _lastUploadedMessageId;

  static Future<void> init() async {
    if (_instance != null) {
      throw Exception("SimpleLocalRepository already exists");
    }
    _instance = SimpleLocalRepository._();
    await _instance!._loadLastMessageIdFromStorage();
  }

  SimpleLocalRepository._();

  static SimpleLocalRepository get instance {
    if (_instance == null) {
      throw Exception("SimpleLocalRepository not initialized");
    }
    return _instance!;
  }

  Future<void> refresh() async {
    final mapper = TransactionsMapper();
    final messages = await _smsProvider.fetchRecentMessages(
        fromId: _lastUploadedMessageId ?? 0);
    _repository.saveTransactions(messages
        .map((m) => mapper.mapFromAToB(m))
        .whereType<Transaction>()
        .toList());
    final latestId = await _repository.getLatestId();
    if (latestId != null) {
      _setLastUploadedMessageId(latestId);
    }
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
}
