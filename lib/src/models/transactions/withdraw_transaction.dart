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

part 'withdraw_transaction.g.dart';

@Collection()
class WithdrawTransaction extends Transaction {
  static const type = "withdraw";
  static final regex = RegExp(
      r'^(\w{0,12})\s[C,c]onfirmed.on\s(.{0,8})\sat\s(\d\d?:\d\d)\s(PM|AM)Withdraw\sKsh(.+\.\d\d)\sfrom\s(\d+)\s-\s(.+)\sNew\sM-PESA\sbalance\sis\sKsh(.+\.\d\d)\.\sTransaction\scost,\sKsh(\d\w{0,7}\.\d\d)\..*$');

  final String location;

  @Name("agent_number")
  final String agentNumber;

  WithdrawTransaction(
      {required super.balance,
      required this.agentNumber,
      required super.dateTime,
      required super.messageId,
      required super.subject, // Set to location for now
      required super.transactionAmount,
      required super.transactionCode,
      required super.transactionCost,
      required this.location});

  factory WithdrawTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return WithdrawTransaction(
        balance: Money.fromString(message: match.group(8).toString().trim()),
        agentNumber: match.group(6).toString().trim(),
        dateTime: getDateTimeFromMessage(
            date: match.group(2).toString().trim(),
            time: match.group(3).toString().trim(),
            isAM: match.group(4).toString().trim() == "AM"),
        messageId: messageID,
        subject: match.group(7).toString().trim(),
        transactionAmount:
            Money.fromString(message: match.group(5).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        transactionCost:
            Money.fromString(message: match.group(9).toString().trim()),
        location: match.group(7).toString().trim());
  }

  factory WithdrawTransaction.fromJson(Map<String, dynamic> json) {
    return WithdrawTransaction(
      agentNumber: json["agentNumber"]!,
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      location: json["location"]!,
      messageId: int.parse(json["messageId"]!),
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
      transactionCost: Money(amount: int.parse(json["transactionCost"]!)),
      subject: json["subject"]!,
    );
  }

  @override
  Map<String, String> toJson() => {
        "agentNumber": agentNumber,
        "balance": balance.amount.toString(),
        "dateTime": dateTime.millisecondsSinceEpoch.toString(),
        "location": location,
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
        type: TransactionType.withdrawMoney);
  }

  @override
  String toString() => toJson().toString();

  @override
  Widget toTransactionListItem(BuildContext context) {
    return PrimaryItemCard(
      icon: const CircleAvatar(
        child: Text("W"),
      ),
      title: "Withdraw",
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
  Widget toRichComponent(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: transactionCode, style: styledTransactionTextStyle),
      const TextSpan(text: "Confirmed."),
      ...commonRichDateTimeComponents(dateTime),
      const TextSpan(text: "Withdraw "),
      richAmount(transactionAmount),
      const TextSpan(text: " from "),
      TextSpan(text: subject, style: styledTransactionTextStyle),
      ...commonRichBalanceComponent(balance),
      ...commonTransactionCostComponent(transactionCost)
    ]));
  }
}
