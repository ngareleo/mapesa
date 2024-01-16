import 'package:flutter/material.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

class PaybillTransaction extends Transaction {
  final String subjectAccount;
  static const type = "paybill";

  const PaybillTransaction(
      {required super.messageId,
      required super.transactionAmount,
      required super.transactionCode,
      required super.transactionCost,
      required super.dateTime,
      required super.balance,
      required this.subjectAccount,
      required super.subject});

  factory PaybillTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return PaybillTransaction(
        messageId: messageID,
        transactionAmount:
            Money.fromString(message: match.group(2).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        transactionCost:
            Money.fromString(message: match.group(9).toString().trim()),
        dateTime: getDateTimeFromMessage(
            date: match.group(5).toString().trim(),
            time: match.group(6).toString().trim(),
            isAM: match.group(7).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(8).toString().trim()),
        subject: match.group(3).toString().trim(),
        subjectAccount: match.group(4).toString().trim());
  }

  @override
  Map<String, String?> toJson() {
    return {
      "balance": balance.amount.toString(),
      "dateTime": dateTime.millisecondsSinceEpoch.toString(),
      "messageId": messageId.toString(),
      "subject": subject,
      "subjectAccount": subjectAccount,
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
      icon: const Text("P"),
      title: "$subjectAccount - $subject",
      subtitle: prettifyTimeDifference(dateTime),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }
}
