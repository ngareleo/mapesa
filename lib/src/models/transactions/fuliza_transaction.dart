import 'package:flutter/material.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

class FulizaTransaction extends Transaction {
  static const type = "fuliza";

  final Money interest;

  const FulizaTransaction({
    required super.messageId,
    required super.transactionAmount,
    required super.transactionCode,
    required super.balance,
    required super.dateTime,
    required this.interest,
  }) : super(transactionCost: const Money(amount: 0), subject: "Fuliza");

  factory FulizaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return FulizaTransaction(
        dateTime: DateTime
            .now(), // TODO: Fix this by looking for subsequent message with date
        messageId: messageID,
        transactionAmount:
            Money.fromString(message: match.group(2).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        interest: Money.fromString(message: match.group(3).toString().trim()),
        balance: Money.fromString(
            message: match.group(4).toString().trim(), isNegative: true));
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
