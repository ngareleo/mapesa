import 'package:flutter/material.dart';
import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';

import '../../utils/money.dart';
import 'transaction.dart';

class FulizaTransaction extends Transaction {
  static const type = "fuliza";

  final Money interest;

  const FulizaTransaction(
      {required int messageId,
      required Money transactionAmount,
      required String transactionCode,
      required Money balance,
      required this.interest})
      : super(
            messageId: messageId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: null,
            dateTime: null,
            balance: balance);

  factory FulizaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return FulizaTransaction(
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
      "type": type,
      "messageId": messageId.toString(),
      "transactionAmount": transactionAmount?.amount.toString(),
      "transactionCode": transactionCode,
      "interest": interest.amount.toString(),
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
      title: "Fuliza",
      subtitle: prettifyTimeDifference(dateTime ?? DateTime.now()),
      icon: const Text("F"),
      rightWidget: Text(
        "Ksh. $amount",
      ),
      onTap: () {},
    );
  }
}
