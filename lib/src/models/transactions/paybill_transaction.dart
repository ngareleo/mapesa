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
      r'^(?<code>\w+)\s[Cc]onfirmed\.\sKsh(?<amount>.+\.\d\d)\ssent\sto\s(?<subject>.*)\s*for\saccount\s(?<account>.+)\son\s(?<date>\d*\/\d*\/\d*) at (?<time>\d*:\d*)\s(?<am>AM|PM)\sNew\sM-PESA\sbalance\sis\sKsh(?<balance>.*\.\d\d).*Transaction\scost,\sKsh(?<cost>\d*\.\d\d).*$');

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
      balance:
          Money.fromString(message: match.namedGroup("balance").toString()),
      dateTime: getDateTimeFromMessage(
        date: match.namedGroup("date").toString().trim(),
        time: match.namedGroup("time").toString().trim(),
        isAM: match.namedGroup("am").toString().trim() == "AM",
      ),
      messageId: messageID,
      subject: match.namedGroup("subject").toString().trim(),
      subjectAccount: match.namedGroup("account").toString().trim(),
      transactionAmount:
          Money.fromString(message: match.namedGroup("amount").toString()),
      transactionCode: match.namedGroup("code").toString().trim(),
      transactionCost:
          Money.fromString(message: match.namedGroup("cost").toString()),
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
  Map<String, String> toJson() => {
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
