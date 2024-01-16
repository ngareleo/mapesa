import 'package:flutter/material.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

class DepositTransaction extends Transaction {
  final String location;
  static const type = "deposit";

  const DepositTransaction(
      {required super.messageId,
      required super.transactionAmount,
      required super.transactionCode,
      required super.dateTime,
      required super.balance,
      required this.location})
      : super(
          subject: "Deposit",
          transactionCost: const Money(amount: 0),
        );

  factory DepositTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return DepositTransaction(
        messageId: messageID,
        transactionAmount:
            Money.fromString(message: match.group(5).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        dateTime: getDateTimeFromMessage(
            date: match.group(2).toString().trim(),
            time: match.group(3).toString().trim(),
            isAM: match.group(4).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(7).toString().trim()),
        location: match.group(6).toString().trim());
  }

  @override
  Map<String, String?> toJson() {
    return {
      "balance": balance.amount.toString(),
      "dateTime": dateTime.millisecondsSinceEpoch.toString(),
      "location": location,
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
      title: "Deposit",
      subtitle: prettifyTimeDifference(dateTime),
      icon: const Text("D"),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }
}
