import 'package:mapesa/src/utils/money.dart';

enum TransactionType {
  receiveMoney,
  sendMoney,
  lipaNaMpesa,
  payBillMoney,
  airtime,
  airtimeFor,
  withdrawMoney,
  fuliza,
  depositMoney,
}

abstract class Transaction {
  final int? messageId;
  final String? userId;
  final String? transactionCode;
  final Money? transactionCost;
  final DateTime? dateTime;
  final Money? balance;
  final Money? transactionAmount;

  const Transaction(
      {required this.messageId,
      required this.userId,
      required this.transactionAmount,
      required this.transactionCode,
      required this.transactionCost,
      required this.dateTime,
      required this.balance});

  Map<String, String?> toJson();
}

class InvalidTransaction extends Transaction {
  InvalidTransaction()
      : super(
            messageId: null,
            userId: null,
            transactionAmount: null,
            transactionCode: null,
            transactionCost: null,
            dateTime: null,
            balance: null);

  @override
  Map<String, String?> toJson() {
    return {"type": "invalid"};
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
