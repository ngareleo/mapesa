import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/pages/m1/transaction_info_page.dart';
import 'package:mapesa/src/pages/m2/transaction_info_page.dart';
import 'package:mapesa/src/types.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'deposit_transaction.g.dart';

@Collection()
class DepositTransaction extends Transaction {
  static const type = "deposit";
  static final regex = RegExp(
      r'^(?<code>\w{9,11})\sConfirmed\.\sOn\s(?<date>\d{1,2}\/\d{1,2}\/\d{2,4})\sat\s(?<time>\d{1,2}:\d{2})\s(?<am>AM|PM)\sGive\sKsh(?<amount>[\d,]*.\d\d)\scash\sto\s(?<location>.*)\sNew\sM-PESA\sbalance\sis\sKsh(?<balance>[\d,]*.\d\d)\..*$');

  final String location;

  DepositTransaction(
      {required super.balance,
      required super.dateTime,
      required super.messageId,
      required super.transactionAmount,
      required super.transactionCode,
      required this.location})
      : super(
          subject: "Deposit",
          transactionCost: Money(amount: 0),
        );

  factory DepositTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return DepositTransaction(
      balance: Money.fromString(
          message: match.namedGroup("balance").toString().trim()),
      dateTime: getDateTimeFromMessage(
        date: match.namedGroup("date").toString().trim(),
        time: match.namedGroup("time").toString().trim(),
        isAM: match.namedGroup("am").toString().trim() == "AM",
      ),
      location: match.namedGroup("location").toString().trim(),
      messageId: messageID,
      transactionAmount: Money.fromString(
          message: match.namedGroup("amount").toString().trim()),
      transactionCode: match.namedGroup("code").toString().trim(),
    );
  }

  factory DepositTransaction.fromJson(Map<String, dynamic> json) {
    return DepositTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      messageId: int.parse(json["messageId"]!),
      location: json["location"]!,
      transactionAmount: Money(amount: int.parse(json["transactionAmount"]!)),
      transactionCode: json["transactionCode"]!,
    );
  }

  @override
  Map<String, String> toJson() => {
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
        location: location,
        subject: subject,
        transactionAmount: transactionAmount,
        transactionCode: transactionCode,
        transactionCost: transactionCost,
        type: TransactionType.depositMoney);
  }

  @override
  Widget toTransactionListItem(BuildContext context) {
    final amount = transactionAmount.amount.toString();
    return PrimaryItemCard(
      title: "Deposit",
      subtitle: prettifyTimeDifference(dateTime),
      icon: const CircleAvatar(
        child: Text("D"),
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
      },
    );
  }

  @override
  String toString() => toJson().toString();
}
