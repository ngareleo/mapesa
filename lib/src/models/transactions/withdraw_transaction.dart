import 'package:flutter/material.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

class WithdrawTransaction extends Transaction {
  final String location;
  final String agentNumber;
  static const type = "withdraw";

  const WithdrawTransaction(
      {required super.messageId,
      required super.transactionAmount,
      required super.transactionCode,
      required super.transactionCost,
      required super.dateTime,
      required super.balance,
      required super.subject, // Set to location for now
      required this.location,
      required this.agentNumber});

  factory WithdrawTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return WithdrawTransaction(
        messageId: messageID,
        transactionAmount:
            Money.fromString(message: match.group(5).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        transactionCost:
            Money.fromString(message: match.group(9).toString().trim()),
        dateTime: getDateTimeFromMessage(
            date: match.group(2).toString().trim(),
            time: match.group(3).toString().trim(),
            isAM: match.group(4).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(8).toString().trim()),
        subject: match.group(7).toString().trim(),
        location: match.group(7).toString().trim(),
        agentNumber: match.group(6).toString().trim());
  }

  @override
  Map<String, String?> toJson() {
    return {
      "agentNumber": agentNumber,
      "balance": balance.amount.toString(),
      "dateTime": dateTime.millisecondsSinceEpoch.toString(),
      "location": location,
      "messageId": messageId.toString(),
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
      icon: const Text("W"),
      title: "Withdraw",
      subtitle: prettifyTimeDifference(dateTime),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }
}
