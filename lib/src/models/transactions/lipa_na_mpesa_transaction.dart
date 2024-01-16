import 'package:flutter/material.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

class LipaNaMpesaTransaction extends Transaction {
  static const type = "buygoods";

  const LipaNaMpesaTransaction(
      {required super.messageId,
      required super.transactionAmount,
      required super.transactionCode,
      required super.dateTime,
      required super.balance,
      required super.subject})
      : super(transactionCost: const Money(amount: 0));

  factory LipaNaMpesaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return LipaNaMpesaTransaction(
        messageId: messageID,
        transactionAmount: Money.fromString(message: match.group(2).toString()),
        transactionCode: match.group(1).toString(),
        dateTime: getDateTimeFromMessage(
            date: match.group(4).toString().trim(),
            time: match.group(5).toString().trim(),
            isAM: match.group(6).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(7).toString()),
        subject: match.group(3).toString());
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
      title: subject,
      subtitle: prettifyTimeDifference(dateTime),
      icon: const Text("L"),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }
}
