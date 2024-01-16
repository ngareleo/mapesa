import 'package:flutter/material.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

class ReceiveMoneyTransaction extends Transaction {
  final String phoneNumber;
  static const type = "receive";

  const ReceiveMoneyTransaction(
      {required super.messageId,
      required super.transactionAmount,
      required super.transactionCode,
      required super.dateTime,
      required super.balance,
      required super.subject,
      required this.phoneNumber})
      : super(transactionCost: const Money(amount: 0));

  factory ReceiveMoneyTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return ReceiveMoneyTransaction(
        messageId: messageID,
        transactionAmount: Money.fromString(message: match.group(2).toString()),
        transactionCode: match.group(1).toString(),
        dateTime: getDateTimeFromMessage(
            date: match.group(8).toString().trim(),
            time: match.group(9).toString().trim(),
            isAM: match.group(10).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(11).toString()),
        subject: match.group(4) ?? match.group(6).toString(),
        phoneNumber: match.group(5) ?? match.group(7).toString());
  }

  @override
  Map<String, String?> toJson() {
    return {
      "balance": balance.amount.toString(),
      "dateTime": dateTime.millisecondsSinceEpoch.toString(),
      "messageId": messageId.toString(),
      "subject": subject,
      "subjectPhoneNumber": phoneNumber,
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
      icon: const Text("R"),
      title: subject,
      subtitle: prettifyTimeDifference(dateTime),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }
}
