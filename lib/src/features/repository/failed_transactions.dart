import 'package:isar/isar.dart';
import 'package:mapesa/src/types.dart';

class FailedTransactionsRepository {
  final Isar _isar;

  FailedTransactionsRepository(this._isar);

  Future<void> saveFailedTransactions(
      List<Map<String, String>> failedTransactions) async {}

  Future<ListOfObjects> getFailedTransactions() async {
    return await _isar.failedTransactions.getAll();
  }

  Future<void> deleteFailedTransactions() async {
    await _isar.writeTxn((isar) async {
      await isar.failedTransactions.deleteAll();
    });
  }
}
