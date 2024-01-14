import 'package:flutter/material.dart';
import 'package:mapesa/src/common/cards/primary_item_card.dart';

import '../../utils/datetime.dart';
import '../../utils/money.dart';
import 'transaction.dart';

class AirtimeTransaction extends Transaction {
  static const type = "airtime";

  const AirtimeTransaction({
    required int messageId,
    required Money transactionAmount,
    required String transactionCode,
    required DateTime dateTime,
    required Money balance,
  }) : super(
            messageId: messageId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: const Money(amount: 0),
            dateTime: dateTime,
            balance: balance);

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
      "type": type,
      "messageId": messageId.toString(),
      "transactionAmount": transactionAmount?.amount.toString(),
      "transactionCode": transactionCode,
      "transactionCost": transactionCost?.amount.toString(),
      "dateTime": dateTime?.millisecondsSinceEpoch.toString(),
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
        title: "Airtime",
        subtitle: prettifyTimeDifference(dateTime ?? DateTime.now()),
        icon: const Text("A"),
        rightWidget: Text("KES $amount"),
        onTap: () {
          // TODO: open transaction details page
        });
  }
}
