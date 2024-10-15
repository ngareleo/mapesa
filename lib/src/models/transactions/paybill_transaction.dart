import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/common/cards/rich_transaction_components.dart';
import 'package:mapesa/src/common/theme.dart';
import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/pages/m1/transaction_info_page.dart';
import 'package:mapesa/src/pages/m2/transaction_info_page.dart';
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
  CompactTransaction? toCompactTransaction() {
    return CompactTransaction(
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
  Widget toTransactionListItem(BuildContext context) {
    return PrimaryItemCard(
      icon: const CircleAvatar(
        child: Text("P"),
      ),
      title: "$subjectAccount - $subject",
      subtitle: prettifyTimeDifference(dateTime),
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
      const TextSpan(text: "Confirmed. "),
      richAmount(transactionAmount),
      const TextSpan(text: " sent to "),
      TextSpan(text: subject, style: styledTransactionTextStyle),
      const TextSpan(text: " for account "),
      TextSpan(text: subjectAccount, style: styledTransactionTextStyle),
      ...commonRichDateTimeComponents(dateTime),
      ...commonRichBalanceComponent(balance),
      ...commonTransactionCostComponent(transactionCost)
    ]));
  }
}
