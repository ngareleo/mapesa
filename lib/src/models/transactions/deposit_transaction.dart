import 'package:flutter/material.dart';
import 'package:mapesa/src/common/cards/primary_item_card.dart';

import '../../utils/datetime.dart';
import '../../utils/money.dart';
import 'transaction.dart';

class DepositTransaction extends Transaction {
  final String location;
  static const type = "deposit";

  const DepositTransaction(
      {required int messageId,
      required Money transactionAmount,
      required String transactionCode,
      required DateTime dateTime,
      required Money balance,
      required this.location})
      : super(
            messageId: messageId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: const Money(amount: 0),
            dateTime: dateTime,
            balance: balance);

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
      "type": type,
      "messageId": messageId.toString(),
      "transactionAmount": transactionAmount?.amount.toString(),
      "transactionCode": transactionCode,
      "transactionCost": transactionCost?.amount.toString(),
      "dateTime": dateTime?.millisecondsSinceEpoch.toString(),
      "location": location,
      "balance": balance?.amount.toString()
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  Widget toTransactionListItem() {
    final amount = transactionAmount?.amount.toString() ?? "0.00";
    return PrimaryItemCard(
      title: "Deposit",
      subtitle: prettifyTimeDifference(dateTime ?? DateTime.now()),
      icon: const Text("D"),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }
}
