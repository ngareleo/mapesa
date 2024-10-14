import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/types.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'receive_money_transaction.g.dart';

@Collection()
class ReceiveMoneyTransaction extends Transaction {
  static const type = "receive";
  static final regex = RegExp(
      r'^(?:Congratulations!\s)?(?<code>\w{10})\s[Cc]onfirmed.You\shave\sreceived\sKsh(?<amount>.+\.\d\d)\sfrom\s(?<from>.*)\son\s(?<date>\d*\/\d*\/\d*)\sat\s(?<time>\d*:\d*)\s(?<am>AM|PM).*New\sM-PESA\sbalance\sis\sKsh(?<balance>.+\.\d\d).*$');

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
      balance:
          Money.fromString(message: match.namedGroup("balance").toString()),
      dateTime: getDateTimeFromMessage(
          date: match.namedGroup("date").toString().trim(),
          time: match.namedGroup("time").toString().trim(),
          isAM: match.namedGroup("am").toString().trim() == "AM"),
      messageId: messageID,
      phoneNumber: "",
      subject: match.namedGroup("from").toString().trim(),
      transactionAmount: Money.fromString(
          message: match.namedGroup("amount").toString().trim()),
      transactionCode: match.namedGroup("code").toString().trim(),
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
  Map<String, String> toJson() => {
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

  @override
  CompactTransaction? toCompactTransaction() {
    return CompactTransaction(
      balance: balance,
      dateTime: dateTime,
      messageId: messageId,
      phoneNumber: phoneNumber,
      subject: subject,
      transactionAmount: transactionAmount,
      transactionCode: transactionCode,
      transactionCost: transactionCost,
      type: TransactionType.receiveMoney,
    );
  }

  @override
  String toString() => toJson().toString();

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
