import 'package:mapesa/src/features/upload/patterns.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

import '../../models/transactions/airtime_for_transaction.dart';
import '../../models/transactions/airtime_transaction.dart';
import '../../models/transactions/deposit_transaction.dart';
import '../../models/transactions/fuliza_transaction.dart';
import '../../models/transactions/lipa_na_mpesa_transaction.dart';
import '../../models/transactions/paybill_transaction.dart';
import '../../models/transactions/receive_money_transaction.dart';
import '../../models/transactions/send_money_transaction.dart';
import '../../models/transactions/withdraw_transaction.dart';

class Mapper {
  /// if regex pattern is null, the message is invalid

  final patterns = const Patterns();

  Transaction? getTransaction(
      {required TransactionType type,
      required String message,
      required int messageID,
      required RegExp expression}) {
    var match = expression.firstMatch(message);
    if (match == null) {
      return null;
    }
    switch (type) {
      case TransactionType.receiveMoney:
        return ReceiveMoneyTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
      case TransactionType.sendMoney:
        return SendMoneyTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
      case TransactionType.lipaNaMpesa:
        return LipaNaMpesaTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
      case TransactionType.payBillMoney:
        return PaybillTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
      case TransactionType.airtime:
        return AirtimeTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
      case TransactionType.withdrawMoney:
        return WithdrawTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
      case TransactionType.fuliza:
        return FulizaTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
      case TransactionType.depositMoney:
        return DepositTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
      case TransactionType.airtimeFor:
        return AirtimeForTransaction.fromMpesaMessage(
            messageID: messageID, match: match);
    }
  }

  Transaction? mapMessageToTransaction(
      {required String? message, required int? messageID}) {
    if (messageID == null || message == null) {
      return null;
    }
    for (var map in patterns.mappingPatterns.entries) {
      var transactionType = map.key;
      var expression = patterns.transactionPatterns[transactionType];
      var isMatch = expression?.hasMatch(message);
      if (isMatch != null && expression != null && isMatch) {
        return getTransaction(
            type: transactionType,
            message: message,
            messageID: messageID,
            expression: expression);
      }
    }
    return null;
  }
}
