import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/pages/m1/transaction_info_page.dart';
import 'package:mapesa/src/pages/m2/transaction_info_page.dart';
import 'package:mapesa/src/types.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

part 'airtime_for_transaction.g.dart';

@Collection()
class AirtimeForTransaction extends Transaction {
  static var regex = RegExp(
      r"([A-Z0-9]{10}) Confirmed\. Ksh([0-9,]+) sent to ([0-9]{10}) on ([0-9]{2}\/[0-9]{2}\/[0-9]{2}) at ([0-9]{2}:[0-9]{2} [AP]M)\. New M-PESA balance is Ksh([0-9,]+)\.");
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
  factory AirtimeForTransaction.fromJson(Map<String, dynamic> json) {
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
  CompactTransaction? toCompactTransaction() {
    return CompactTransaction(
      balance: balance,
      dateTime: dateTime,
      messageId: messageId,
      subject: subject,
      transactionAmount: transactionAmount,
      transactionCode: transactionCode,
      transactionCost: transactionCost,
      type: TransactionType.airtimeFor,
    );
  }

  @override
  String toString() => toJson().toString();

  @override
  Widget toTransactionListItem(BuildContext context) {
    final amount = transactionAmount.amount.toString();
    return PrimaryItemCard(
        title: "Airtime",
        subtitle: prettifyTimeDifference(dateTime),
        icon: const CircleAvatar(
          child: Text("AF"),
        ),
        rightWidget: Text("KES $amount"),
        onTap: () {
          final mapesaM1Enabled = FeatureFlagsProvider.client
              .hasCachedFeatureFlag(Flags.NEW_MAPESA_M1);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => mapesaM1Enabled
                      ? TransactionInfoPageV2(this)
                      : const TransactionInfoPage()));
        });
  }
}
