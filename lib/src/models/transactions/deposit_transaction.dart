import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/pages/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'deposit_transaction.g.dart';

@Collection()
class DepositTransaction extends Transaction {
  final String location;
  static const type = "deposit";

  DepositTransaction(
      {required super.balance,
      required super.dateTime,
      required super.messageId,
      required super.transactionAmount,
      required super.transactionCode,
      required this.location})
      : super(
          subject: "Deposit",
          transactionCost: Money(amount: 0),
        );

  factory DepositTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return DepositTransaction(
      balance: Money.fromString(message: match.group(7).toString().trim()),
      dateTime: getDateTimeFromMessage(
          date: match.group(2).toString().trim(),
          time: match.group(3).toString().trim(),
          isAM: match.group(4).toString().trim() == "AM"),
      location: match.group(6).toString().trim(),
      messageId: messageID,
      transactionAmount:
          Money.fromString(message: match.group(5).toString().trim()),
      transactionCode: match.group(1).toString().trim(),
    );
  }

  @override
  Transaction fromJson(Map<String, dynamic> json) {
    return DepositTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      messageId: int.parse(json["messageId"]!),
      location: json["location"]!,
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
    );
  }

  @override
  Map<String, String?> toJson() {
    return {
      "balance": balance.amount.toString(),
      "dateTime": dateTime.millisecondsSinceEpoch.toString(),
      "location": location,
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
      title: "Deposit",
      subtitle: prettifyTimeDifference(dateTime),
      icon: const Text("D"),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
