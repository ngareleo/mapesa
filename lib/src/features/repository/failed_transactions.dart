import 'package:isar/isar.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/models/transactions/airtime_for_transaction.dart';
import 'package:mapesa/src/types.dart';

class FailedTransactionsRepository {
  final Isar _isar;

  FailedTransactionsRepository(this._isar);

  Future<void> saveFailedTransactions(ListOfObjects failedTransactions) async {
    var failedTransactionsMapper = FailedTransactionsMapper();
    var failedTransactionsList = failedTransactions
        .map((failedTransaction) =>
            failedTransactionsMapper.mapFromAToB(failedTransaction))
        .toList();
    await _isar.writeTxn(() async {
      for (var failedTransaction in failedTransactionsList) {
        switch (failedTransactions.runtimeType) {
          case AirtimeForTransaction:
            await _isar.airtimeForTransactions.put(failedTransaction);
            break;
          case AirtimeTransaction:
            await _isar.airtimeTransactions.put(failedTransaction);
            break;
          case DepositTransaction:
            await _isar.depositTransactions.put(failedTransaction);
            break;
          case FulizaTransaction:
            await _isar.fulizaTransactions.put(failedTransaction);
            break;
          case LipaNaMpesaTransaction:
            await _isar.lipaNaMpesaTransactions.put(failedTransaction);
            break;
          case PaybillTransaction:
            await _isar.paybillTransactions.put(failedTransaction);
            break;
          case ReceiveMoneyTransaction:
            await _isar.receiveMoneyTransactions.put(failedTransaction);
            break;
          case SendMoneyTransaction:
            await _isar.sendMoneyTransactions.put(failedTransaction);
            break;
          case WithdrawTransaction:
            await _isar.withdrawTransactions.put(failedTransaction);
            break;
          default:
            break;
        }
      }
    });
  }

  Future<void> deleteFailedTransactions() async {}
}
