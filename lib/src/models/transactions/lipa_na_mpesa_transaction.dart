import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/pages/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'lipa_na_mpesa_transaction.g.dart';

@Collection()
class LipaNaMpesaTransaction extends Transaction {
  static const type = "buygoods";

  LipaNaMpesaTransaction(
      {required super.balance,
      required super.dateTime,
      required super.messageId,
      required super.subject,
      required super.transactionAmount,
      required super.transactionCode})
      : super(transactionCost: Money(amount: 0));

  factory LipaNaMpesaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return LipaNaMpesaTransaction(
        balance: Money.fromString(message: match.group(7).toString()),
        dateTime: getDateTimeFromMessage(
            date: match.group(4).toString().trim(),
            time: match.group(5).toString().trim(),
            isAM: match.group(6).toString().trim() == "AM"),
        messageId: messageID,
        subject: match.group(3).toString(),
        transactionAmount: Money.fromString(message: match.group(2).toString()),
        transactionCode: match.group(1).toString());
  }

  @override
  Transaction fromJson(Map<String, dynamic> json) {
    return LipaNaMpesaTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      messageId: int.parse(json["messageId"]!),
      subject: json["subject"]!,
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
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

  @override
  String toString() {
    return toJson().toString();
  }
}
