import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'fuliza_transaction.g.dart';

@Collection()
class FulizaTransaction extends Transaction {
  static const type = "fuliza";
  static final regex = RegExp(
      r'^(\w{9,11})\s[Cc]onfirmed\.\sFuliza\sM-PESA\samount\sis\sKsh\s(.+\.\d{2})\.\sInterest charged Ksh (\d+\.\d{2})\.\sTotal\sFuliza\sM-PESA\soutstanding\samount\sis\sKsh\s(\d\w{0,7}\.\d\d)');

  final Money interest;

  FulizaTransaction({
    required super.balance,
    required super.dateTime,
    required super.messageId,
    required super.transactionAmount,
    required super.transactionCode,
    required this.interest,
  }) : super(subject: "Fuliza", transactionCost: Money(amount: 0));

  factory FulizaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return FulizaTransaction(
        balance: Money.fromString(
            message: match.group(4).toString().trim(), isNegative: true),
        dateTime: DateTime
            .now(), // TODO: Fix this by looking for subsequent message with date
        messageId: messageID,
        transactionAmount:
            Money.fromString(message: match.group(2).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        interest: Money.fromString(message: match.group(3).toString().trim()));
  }

  @override
  factory FulizaTransaction.fromJson(Map<String, dynamic> json) {
    return FulizaTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      interest: Money(amount: int.parse(json["interest"]!)),
      messageId: int.parse(json["messageId"]!),
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
    );
  }

  @override
  Map<String, String?> toJson() {
    return {
      "balance": balance.amount.toString(),
      "dateTime": dateTime.millisecondsSinceEpoch.toString(),
      "interest": interest.amount.toString(),
      "messageId": messageId.toString(),
      "subject": subject,
      "transactionAmount": transactionAmount.amount.toString(),
      "transactionCode": transactionCode,
      "transactionCost": transactionCost.amount.toString(),
      "type": type,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  Widget toTransactionListItem() {
    final amount = transactionAmount.amount.toString();
    return PrimaryItemCard(
      title: "Fuliza",
      subtitle: prettifyTimeDifference(dateTime),
      icon: const Text("F"),
      rightWidget: Text(
        "Ksh. $amount",
      ),
      onTap: () {},
    );
  }
}
