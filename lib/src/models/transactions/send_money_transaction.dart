import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/pages/common/cards/primary_item_card.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'send_money_transaction.g.dart';

@Collection()
class SendMoneyTransaction extends Transaction {
  static const type = "send";
  @Name("phone_number")
  final String phoneNumber;

  SendMoneyTransaction({
    required super.balance,
    required super.dateTime,
    required super.messageId,
    required super.subject,
    required super.transactionAmount,
    required super.transactionCode,
    required super.transactionCost,
    required this.phoneNumber,
  });

  factory SendMoneyTransaction.fromMpesaMessage({
    required int messageID,
    required RegExpMatch match,
  }) {
    return SendMoneyTransaction(
      messageId: messageID,
      transactionAmount: Money.fromString(
        message: match.group(2).toString().trim(),
      ),
      transactionCode: match.group(1).toString().trim(),
      transactionCost: Money.fromString(
        message: match.group(9).toString().trim(),
      ),
      dateTime: getDateTimeFromMessage(
        date: match.group(5).toString().trim(),
        time: match.group(6).toString().trim(),
        isAM: match.group(7).toString().trim() == "AM",
      ),
      balance: Money.fromString(
        message: match.group(8).toString().trim(),
      ),
      subject: match.group(3).toString().trim(),
      phoneNumber: match.group(4).toString().trim(),
    );
  }

  @override
  Transaction fromJson(Map<String, dynamic> json) {
    return SendMoneyTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      messageId: int.parse(json["messageId"]!),
      subject: json["subject"]!,
      phoneNumber: json["subjectPhoneNumber"]!,
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
      transactionCost: Money(amount: int.parse(json["transactionCost"]!)),
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
      icon: const Text("P"),
      title: subject,
      subtitle: prettifyTimeDifference(dateTime),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }
}
