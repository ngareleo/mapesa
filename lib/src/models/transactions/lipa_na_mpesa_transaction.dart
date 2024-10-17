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

part 'lipa_na_mpesa_transaction.g.dart';

@Collection()
class LipaNaMpesaTransaction extends Transaction {
  static const type = "buygoods";
  static final regex = RegExp(
      r'^(\w+)\sConfirmed.\sKsh(.+\.\d\d)\spaid\sto\s(.+)\.\son\s(.+)\sat (.+) (AM|PM).New M-PESA balance is Ksh(.+\.\d\d)\. Transaction cost, Ksh(\d\w{0,7}\.\d\d).*$');

  LipaNaMpesaTransaction(
      {required super.balance,
      required super.dateTime,
      required super.messageId,
      required super.subject,
      required super.transactionAmount,
      required super.transactionCode})
      : super(transactionCost: Money(amount: 0));

  factory LipaNaMpesaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return LipaNaMpesaTransaction(
        balance: Money.fromString(message: match.group(7).toString()),
        dateTime: getDateTimeFromMessage(
            date: match.group(4).toString().trim(),
            time: match.group(5).toString().trim(),
            isAM: match.group(6).toString().trim() == "AM"),
        messageId: messageID,
        subject: match.group(3).toString(),
        transactionAmount: Money.fromString(message: match.group(2).toString()),
        transactionCode: match.group(1).toString());
  }

  @override
  factory LipaNaMpesaTransaction.fromJson(Map<String, dynamic> json) {
    return LipaNaMpesaTransaction(
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
        type: TransactionType.lipaNaMpesa);
  }

  @override
  Widget toTransactionListItem(BuildContext context) {
    return PrimaryItemCard(
      title: subject,
      subtitle: prettifyTimeDifference(dateTime),
      icon: const CircleAvatar(
        child: Text("L"),
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
      },
    );
  }

  @override
  String toString() => toJson().toString();

  @override
  Widget toRichComponent(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: transactionCode, style: styledTransactionTextStyle),
      const TextSpan(text: " Confirmed. "),
      richAmount(transactionAmount),
      const TextSpan(text: " paid to "),
      TextSpan(text: subject.toString(), style: styledTransactionTextStyle),
      ...commonRichDateTimeComponents(dateTime),
      ...commonRichBalanceComponent(balance),
      ...commonTransactionCostComponent(transactionCost)
    ]));
  }
}
