import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/models/server_side_tmodel.dart';
import 'package:mapesa/src/types.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'paybill_transaction.g.dart';

@Collection()
class PaybillTransaction extends Transaction {
  static const type = "paybill";
  static final regex = RegExp(
      r'^(\w{10})\sConfirmed\.\sKsh(.+\.\d\d)\ssent\sto\s(.+)\sfor\saccount\s(.*)\s?on(.{6,9})\sat\s(\d\d?:\d\d)\s(AM|PM)\.?\sNew\sM-PESA\sbalance\sis\sKsh(.+\.\d\d)\.\sTransaction\scost,\sKsh(.{1,3}\.\d\d?)\..*$');

  final String subjectAccount;

  PaybillTransaction({
    required super.balance,
    required super.dateTime,
    required super.messageId,
    required super.subject,
    required super.transactionAmount,
    required super.transactionCode,
    required super.transactionCost,
    required this.subjectAccount,
  });

  factory PaybillTransaction.fromMpesaMessage({
    required int messageID,
    required RegExpMatch match,
  }) {
    return PaybillTransaction(
      balance: Money.fromString(message: match.group(8).toString().trim()),
      dateTime: getDateTimeFromMessage(
        date: match.group(5).toString().trim(),
        time: match.group(6).toString().trim(),
        isAM: match.group(7).toString().trim() == "AM",
      ),
      messageId: messageID,
      subject: match.group(3).toString().trim(),
      subjectAccount: match.group(4).toString().trim(),
      transactionAmount:
          Money.fromString(message: match.group(2).toString().trim()),
      transactionCode: match.group(1).toString().trim(),
      transactionCost:
          Money.fromString(message: match.group(9).toString().trim()),
    );
  }

  factory PaybillTransaction.fromJson(Map<String, dynamic> json) {
    return PaybillTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      messageId: int.parse(json["messageId"]!),
      subject: json["subject"]!,
      subjectAccount: json["subjectAccount"]!,
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
      transactionCost: Money(amount: int.parse(json["transactionCost"]!)),
    );
  }

  @override
  Map<String, String?> toJson() => {
        "balance": balance.amount.toString(),
        "dateTime": dateTime.millisecondsSinceEpoch.toString(),
        "messageId": messageId.toString(),
        "subject": subject,
        "subjectAccount": subjectAccount,
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
      subjectAccount: subjectAccount,
      transactionAmount: transactionAmount,
      transactionCode: transactionCode,
      transactionCost: transactionCost,
      type: TransactionType.payBillMoney,
    );
  }

  @override
  Widget toTransactionListItem() {
    final amount = transactionAmount.amount.toString();
    return PrimaryItemCard(
      icon: const Text("P"),
      title: "$subjectAccount - $subject",
      subtitle: prettifyTimeDifference(dateTime),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }

  @override
  String toString() => toJson().toString();
}
