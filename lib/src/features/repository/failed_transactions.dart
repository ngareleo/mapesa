import 'package:isar/isar.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/models/server_side_tmodel.dart';
import 'package:mapesa/src/types.dart';

class FailedTransactionsRepository {
  final Isar _isar;
  static FailedTransactionsRepository? _instance;

  static void init(Isar isar) {
    if (_instance != null) {
      throw Exception("FailedTransactionsRepository already initialized");
    }
    _instance = FailedTransactionsRepository._(isar);
  }

  FailedTransactionsRepository._(this._isar);

  static FailedTransactionsRepository get instance {
    if (_instance == null) {
      throw Exception("FailedTransactionsRepository not initialized");
    }
    return _instance!;
  }

  Future<void> saveFailedTransactions(ListOfObjects failedTransactions) async {
    var failedTransactionsMapper = FailedTransactionsMapper();
    var failedTransactionsList = failedTransactions
        .map((failedTransaction) => failedTransactionsMapper
            .mapFromAToB(failedTransaction)!
            .toServerSideTModel())
        .toList();
    const payload = <ServerSideTModel>[];
    for (var failedTransaction in failedTransactionsList) {
      if (failedTransaction != null) {
        payload.add(failedTransaction);
      }
    }
    await _isar.writeTxn(() async {
      await _isar.serverSideTModels.putAll(payload);
    });
  }

  Future<List<ServerSideTModel>> fetchFailedTransactions() async {
    var failedTransactions = await _isar.serverSideTModels.where().findAll();
    return failedTransactions;
  }

  Future<void> deleteAllFailedTransactions() async {
    await _isar.writeTxn(() async {
      await _isar.serverSideTModels.filter().idGreaterThan(0).deleteAll();
    });
  }
}
