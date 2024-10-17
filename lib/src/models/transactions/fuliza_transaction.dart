import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/common/theme.dart';
import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/pages/m1/transaction_info_page.dart';
import 'package:mapesa/src/pages/m2/transaction_info.dart';
import 'package:mapesa/src/types.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'fuliza_transaction.g.dart';

@Collection()
class FulizaTransaction extends Transaction {
  static const type = "fuliza";
  static final regex = RegExp(
      r'^(\w{9,11})\s[Cc]onfirmed\.\sFuliza\sM-PESA\samount\sis\sKsh\s(.+\.\d{2})\.\sInterest charged Ksh (\d+\.\d{2})\.\sTotal\sFuliza\sM-PESA\soutstanding\samount\sis\sKsh\s(\d\w{0,7}\.\d\d)');

  final Money interest;

  FulizaTransaction({
    required super.balance,
    required super.dateTime,
    required super.messageId,
    required super.transactionAmount,
    required super.transactionCode,
    required this.interest,
  }) : super(subject: "Fuliza", transactionCost: Money(amount: 0));

  factory FulizaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return FulizaTransaction(
        balance: Money.fromString(
            message: match.group(4).toString().trim(), isNegative: true),
        dateTime: DateTime
            .now(), // TODO: Fix this by looking for subsequent message with date
        messageId: messageID,
        transactionAmount:
            Money.fromString(message: match.group(2).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        interest: Money.fromString(message: match.group(3).toString().trim()));
  }

  @override
  factory FulizaTransaction.fromJson(Map<String, dynamic> json) {
    return FulizaTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      interest: Money(amount: int.parse(json["interest"]!)),
      messageId: int.parse(json["messageId"]!),
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
    );
  }

  @override
  Map<String, String> toJson() => {
        "balance": balance.amount.toString(),
        "dateTime": dateTime.millisecondsSinceEpoch.toString(),
        "interest": interest.amount.toString(),
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
        interest: interest,
        messageId: messageId,
        subject: subject,
        transactionAmount: transactionAmount,
        transactionCode: transactionCode,
        transactionCost: transactionCost,
        type: TransactionType.fuliza);
  }

  @override
  String toString() => toJson().toString();

  @override
  Widget toTransactionListItem(BuildContext context) {
    final amount = transactionAmount.amount.toString();
    return PrimaryItemCard(
      title: "Fuliza",
      subtitle: prettifyTimeDifference(dateTime),
      icon: const CircleAvatar(
        child: Text("F"),
      ),
      rightWidget: Text(
        "Ksh. $amount",
      ),
      onTap: () {
        final mapesaM1Enabled = FeatureFlagsProvider.client
            .hasCachedFeatureFlag(Flags.NEW_MAPESA_M1);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => mapesaM1Enabled
                    ? TransactionInfoPageV2(this)
                    : const TransactionInfoPage()));
      },
    );
  }

  @override
  Widget toRichComponent(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: transactionCode, style: styledTransactionTextStyle),
      const TextSpan(text: "Confirmed.on "),
      TextSpan(text: dateTime.toString(), style: styledTransactionTextStyle),
      const TextSpan(text: ""),
    ]));
  }
}
