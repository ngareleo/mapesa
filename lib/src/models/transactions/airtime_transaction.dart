import 'package:flutter/material.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

class AirtimeTransaction extends Transaction {
  static const type = "airtime";

  const AirtimeTransaction({
    required super.messageId,
    required super.transactionAmount,
    required super.transactionCode,
    required super.dateTime,
    required super.balance,
  }) : super(
          subject: "Airtime",
          transactionCost: const Money(amount: 0),
        );

  factory AirtimeTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return AirtimeTransaction(
      messageId: messageID,
      transactionAmount:
          Money.fromString(message: match.group(2).toString().trim()),
      transactionCode: match.group(1).toString().trim(),
      dateTime: getDateTimeFromMessage(
          date: match.group(3).toString().trim(),
          time: match.group(4).toString().trim(),
          isAM: match.group(5).toString().trim() == "AM"),
      balance: Money.fromString(message: match.group(6).toString().trim()),
    );
  }

  @override
  Map<String, String?> toJson() {
    return {
      "balance": balance.amount.toString(),
      "dateTime": dateTime.millisecondsSinceEpoch.toString(),
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
        title: "Airtime",
        subtitle: prettifyTimeDifference(dateTime),
        icon: const Text("A"),
        rightWidget: Text("KES $amount"),
        onTap: () {
          // TODO: open transaction details page
        });
  }
}
