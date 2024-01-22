import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/pages/common/cards/primary_item_card.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

part 'airtime_for_transaction.g.dart';

@Collection()
class AirtimeForTransaction extends Transaction {
  static const type = "airtime-for";

  AirtimeForTransaction({
    required super.messageId,
    required super.transactionAmount,
    required super.transactionCode,
    required super.dateTime,
    required super.balance,
    required super.subject,
  }) : super(
          transactionCost: Money(amount: 0),
        );

  factory AirtimeForTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return AirtimeForTransaction(
      messageId: messageID,
      transactionAmount:
          Money.fromString(message: match.group(2).toString().trim()),
      transactionCode: match.group(1).toString().trim(),
      dateTime: getDateTimeFromMessage(
          date: match.group(4).toString().trim(),
          time: match.group(5).toString().trim(),
          isAM: match.group(6).toString().trim() == "AM"),
      balance: Money.fromString(message: match.group(6).toString().trim()),
      subject: match.group(3).toString().trim(),
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
  Transaction fromJson(Map<String, dynamic> json) {
    return AirtimeForTransaction(
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
        onTap: () {});
  }
}
