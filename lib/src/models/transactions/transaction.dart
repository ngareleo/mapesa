import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/utils/money.dart';

enum TransactionType {
  receiveMoney(serverSide: "receive"),
  sendMoney(serverSide: "withdraw"),
  lipaNaMpesa(serverSide: "buygoods"),
  payBillMoney(serverSide: "paybill"),
  airtime(serverSide: "airtime"),
  airtimeFor(serverSide: "airtime_for"),
  withdrawMoney(serverSide: "withdraw"),
  fuliza(serverSide: "fuliza"),
  depositMoney(serverSide: "deposit");

  final String serverSide;
  const TransactionType({required this.serverSide});
}

abstract class Transaction {
  // These fields are constranied to be non-null by backend

  final Id id = Isar.autoIncrement;
  final Money balance;
  final DateTime dateTime;

  @Name("message_id")
  final int messageId;
  final String subject;

  @Name("transaction_amount")
  final Money transactionAmount;
  @Name("transaction_code")
  final String transactionCode;
  @Name("transaction_cost")
  final Money transactionCost;

  const Transaction({
    required this.balance,
    required this.dateTime,
    required this.messageId,
    required this.subject,
    required this.transactionAmount,
    required this.transactionCode,
    required this.transactionCost,
  });

  Map<String, String?> toJson();
  Widget toTransactionListItem();
}

class InvalidTransaction extends Transaction {
  // Takes these params not seriously
  InvalidTransaction()
      : super(
            subject: "Invalid Transaction",
            messageId: 0,
            transactionAmount: Money(amount: 0),
            transactionCode: "",
            transactionCost: Money(amount: 0),
            dateTime: DateTime.fromMicrosecondsSinceEpoch(0),
            balance: Money(amount: 0));

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

typedef MultipleTransactions = List<Transaction>;
