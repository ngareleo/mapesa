import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/models/server_side_tmodel.dart';
import 'package:mapesa/src/types.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'airtime_transaction.g.dart';

@Collection()
class AirtimeTransaction extends Transaction {
  static const type = "airtime";
  static final regex = RegExp(
      r'^(\w{10,12}) confirmed\.You bought Ksh(.+\.\d\d) of airtime on (.+) at (\d\d?:\d\d) (AM|PM)\.New M-PESA balance is Ksh(.+\.\d\d)\. Transaction cost, ');

  AirtimeTransaction({
    required super.messageId,
    required super.transactionAmount,
    required super.transactionCode,
    required super.dateTime,
    required super.balance,
  }) : super(
          subject: "Airtime",
          transactionCost: Money(amount: 0),
        );

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

  factory AirtimeTransaction.fromJson(Map<String, dynamic> json) {
    return AirtimeTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      messageId: int.parse(json["messageId"]!),
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
    );
  }

  @override
  Map<String, String> toJson() => {
        "balance": balance.amount.toString(),
        "dateTime": dateTime.millisecondsSinceEpoch.toString(),
        "messageId": messageId.toString(),
        "subject": subject,
        "transactionAmount": transactionAmount.amount.toString(),
        "transactionCode": transactionCode,
        "transactionCost": transactionCost.amount.toString(),
        "type": type,
      };

  @override
  ServerSideTModel? toServerSideTModel() {
    return ServerSideTModel(
        balance: balance,
        dateTime: dateTime,
        messageId: messageId,
        subject: subject,
        transactionAmount: transactionAmount,
        transactionCode: transactionCode,
        transactionCost: transactionCost,
        type: TransactionType.airtime);
  }

  @override
  String toString() => toJson().toString();

  @override
  Widget toTransactionListItem() {
    final amount = transactionAmount.amount.toString();
    return PrimaryItemCard(
        title: "Airtime",
        subtitle: prettifyTimeDifference(dateTime),
        icon: const Text("A"),
        rightWidget: Text("KES $amount"),
        onTap: () {
          // TODO: open transaction details page
        });
  }
}
