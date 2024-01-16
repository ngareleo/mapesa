import 'package:flutter/material.dart';
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
  // These fields are constranied to be non-null by backend

  final Money balance;
  final DateTime dateTime;
  final int messageId;
  final String subject;
  final Money transactionAmount;
  final String transactionCode;
  final Money transactionCost;

  const Transaction(
      {required this.balance,
      required this.messageId,
      required this.transactionAmount,
      required this.transactionCode,
      required this.transactionCost,
      required this.dateTime,
      required this.subject});

  Map<String, String?> toJson();
  Widget toTransactionListItem();
}

class InvalidTransaction extends Transaction {
  // Takes these params not seriously
  InvalidTransaction()
      : super(
            subject: "Invalid Transaction",
            messageId: 0,
            transactionAmount: const Money(amount: 0),
            transactionCode: "",
            transactionCost: const Money(amount: 0),
            dateTime: DateTime.fromMicrosecondsSinceEpoch(0),
            balance: const Money(amount: 0));

  @override
  Map<String, String?> toJson() {
    return {"type": "invalid"};
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  Widget toTransactionListItem() {
    throw UnimplementedError();
  }
}
