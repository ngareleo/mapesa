import 'package:flutter/material.dart';
import 'package:mapesa/src/common/cards/primary_item_card.dart';

import '../../utils/datetime.dart';
import '../../utils/money.dart';
import 'transaction.dart';

class ReceiveMoneyTransaction extends Transaction {
  final String subject;
  final String phoneNumber;
  static const type = "receive";

  const ReceiveMoneyTransaction(
      {required int messageId,
      required String userId,
      required Money transactionAmount,
      required String transactionCode,
      required DateTime dateTime,
      required Money balance,
      required this.subject,
      required this.phoneNumber})
      : super(
            messageId: messageId,
            userId: userId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: const Money(amount: 0),
            dateTime: dateTime,
            balance: balance);

  factory ReceiveMoneyTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return ReceiveMoneyTransaction(
        messageId: messageID,
        userId: "",
        transactionAmount: Money.fromString(message: match.group(2).toString()),
        transactionCode: match.group(1).toString(),
        dateTime: getDateTimeFromMessage(
            date: match.group(8).toString().trim(),
            time: match.group(9).toString().trim(),
            isAM: match.group(10).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(11).toString()),
        subject: match.group(4) ?? match.group(6).toString(),
        phoneNumber: match.group(5) ?? match.group(7).toString());
  }

  @override
  Map<String, String?> toJson() {
    return {
      "type": type,
      "messageId": messageId.toString(),
      "userId": userId,
      "transactionAmount": transactionAmount?.amount.toString(),
      "transactionCode": transactionCode,
      "transactionCost": transactionCost?.amount.toString(),
      "dateTime": dateTime.toString(),
      "balance": balance?.amount.toString(),
      "subject": subject,
      "subjectPhoneNumber": phoneNumber
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
      icon: const Text("R"),
      title: subject,
      subtitle: prettifyTimeDifference(dateTime ?? DateTime.now()),
      rightWidget: Text("KES $amount"),
      onTap: () {},
    );
  }
}
