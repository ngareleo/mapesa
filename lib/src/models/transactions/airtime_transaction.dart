import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/common/cards/rich_transaction_components.dart';
import 'package:mapesa/src/common/theme.dart';
import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/pages/m1/transaction_info_page.dart';
import 'package:mapesa/src/pages/m2/transaction_info.dart';
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
        "balance": balance.toString(),
        "dateTime": dateTime.millisecondsSinceEpoch.toString(),
        "messageId": messageId.toString(),
        "subject": subject,
        "transactionAmount": transactionAmount.toString(),
        "transactionCode": transactionCode,
        "transactionCost": transactionCost.toString(),
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
        type: TransactionType.airtime);
  }

  @override
  String toString() => toJson().toString();

  @override
  Widget toTransactionListItem(BuildContext context) {
    return PrimaryItemCard(
        title: "Airtime",
        subtitle: prettifyTimeDifference(dateTime),
        icon: const CircleAvatar(
          child: Text("A"),
        ),
        rightWidget: Text("KES $transactionAmount"),
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

  @override
  Widget toRichComponent(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: transactionCode, style: styledTransactionTextStyle),
      const TextSpan(text: " confirmed. You bought "),
      richAmount(transactionAmount),
      const TextSpan(text: " of airtime"),
      ...commonRichDateTimeComponents(dateTime),
      ...commonRichBalanceComponent(balance),
      ...commonTransactionCostComponent(transactionCost)
    ]));
  }
}
