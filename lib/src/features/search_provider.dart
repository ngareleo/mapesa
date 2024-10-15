import 'package:isar/isar.dart';

import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

class SearchProvider {
  final Isar _isar;
  static SearchProvider? _instance;

  static void init(Isar isar) {
    if (_instance != null) {
      throw Exception("SearchProvider is already initialized");
    }
    _instance = SearchProvider._(isar);
  }

  static SearchProvider get instance {
    if (_instance == null) {
      throw Exception("SearchProvider has not been initialized");
    }
    return _instance!;
  }

  SearchProvider._(this._isar);

  Future<Set<Transaction>> suggest({required String seed, int n = 10}) async {
    final mapper = CompactTransactionsMapper();
    final suggestions = (await _isar.compactTransactions
            .where()
            .filter()
            .subjectContains(seed, caseSensitive: false)
            .or()
            .locationContains(seed, caseSensitive: false)
            .or()
            .transactionCodeContains(seed, caseSensitive: false)
            .findAll())
        .map((c) => mapper.mapFromAToB(c))
        .whereType<Transaction>();

    return Set.from(suggestions);
  }
}
