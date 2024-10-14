import 'package:isar/isar.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

class CompactTransactionsRepository {
  final Isar _isar;
  static CompactTransactionsRepository? _instance;

  static void init(Isar isar) {
    if (_instance != null) {
      throw Exception("CompactTransactionsRepository already initialized");
    }
    _instance = CompactTransactionsRepository._(isar);
  }

  CompactTransactionsRepository._(this._isar);

  static CompactTransactionsRepository get instance {
    if (_instance == null) {
      throw Exception("CompactTransactionsRepository not initialized");
    }
    return _instance!;
  }

  Future<void> saveTransactions(List<Transaction> transactions) async {
    var compactTransactions = transactions
        .map((t) => t.toCompactTransaction())
        .whereType<CompactTransaction>()
        .toList();
    await _isar.writeTxn(() async {
      await _isar.compactTransactions.putAll(compactTransactions);
    });
  }
}
