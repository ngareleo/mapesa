import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'receive_money_transaction.g.dart';

@Collection()
class ReceiveMoneyTransaction extends Transaction {
  static const type = "receive";
  static final regex = RegExp(
      r'^You have received Ksh(.+\.\d\d) from (.+?) on (.+) at (\d\d?:\d\d) (AM|PM)\. New M-PESA balance is Ksh(.+\.\d\d)\. Transaction cost, Ksh(\d\w{0,7}\.\d\d)\..*$');

  @Name("phone_number")
  final String phoneNumber;

  ReceiveMoneyTransaction(
      {required super.balance,
      required super.dateTime,
      required super.messageId,
      required this.phoneNumber,
      required super.subject,
      required super.transactionAmount,
      required super.transactionCode})
      : super(transactionCost: Money(amount: 0));

  factory ReceiveMoneyTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return ReceiveMoneyTransaction(
      balance: Money.fromString(message: match.group(11).toString()),
      dateTime: getDateTimeFromMessage(
          date: match.group(8).toString().trim(),
          time: match.group(9).toString().trim(),
          isAM: match.group(10).toString().trim() == "AM"),
      messageId: messageID,
      phoneNumber: match.group(5) ?? match.group(7).toString(),
      subject: match.group(4) ?? match.group(6).toString(),
      transactionAmount: Money.fromString(message: match.group(2).toString()),
      transactionCode: match.group(1).toString(),
    );
  }

  @override
  factory ReceiveMoneyTransaction.fromJson(Map<String, dynamic> json) {
    return ReceiveMoneyTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      messageId: int.parse(json["messageId"]!),
      subject: json["subject"]!,
      phoneNumber: json["subjectPhoneNumber"]!,
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
