import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/common/theme.dart';
import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/pages/m1/transaction_info_page.dart';
import 'package:mapesa/src/pages/m2/transaction_info_page.dart';
import 'package:mapesa/src/types.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import 'transaction.dart';

part 'send_money_transaction.g.dart';

@Collection()
class SendMoneyTransaction extends Transaction {
  static const type = "send";
  static final regex = RegExp(
      r'^(?<code>\w{8,12})\sConfirmed.\sKsh(?<amount>[\d,]*\.\d\d)\ssent\sto\s(?<to>.*)\son\s(?<date>\d{1,2}\/\d{1,2}\/\d{2,4})\sat\s(?<time>\d{1,2}:\d{2})\s(?<am>AM|PM)\.\sNew\sM-PESA\sbalance\sis\sKsh(?<balance>[\d,]*\.\d\d)\.\sTransaction\scost,\sKsh(?<cost>[\d,]*\.\d\d)\..*$');

  @Name("phone_number")
  final String phoneNumber;

  SendMoneyTransaction({
    required super.balance,
    required super.dateTime,
    required super.messageId,
    required super.subject,
    required super.transactionAmount,
    required super.transactionCode,
    required super.transactionCost,
    required this.phoneNumber,
  });

  factory SendMoneyTransaction.fromMpesaMessage({
    required int messageID,
    required RegExpMatch match,
  }) {
    return SendMoneyTransaction(
      balance: Money.fromString(
        message: match.namedGroup("balance").toString().trim(),
      ),
      dateTime: getDateTimeFromMessage(
        date: match.namedGroup("date").toString().trim(),
        time: match.namedGroup("time").toString().trim(),
        isAM: match.namedGroup("am").toString().trim() == "AM",
      ),
      messageId: messageID,
      phoneNumber: "",
      subject: match.namedGroup("to").toString().trim(),
      transactionAmount: Money.fromString(
        message: match.namedGroup("amount").toString().trim(),
      ),
      transactionCode: match.namedGroup("code").toString().trim(),
      transactionCost: Money.fromString(
        message: match.namedGroup("cost").toString().trim(),
      ),
    );
  }

  factory SendMoneyTransaction.fromJson(Map<String, dynamic> json) {
    return SendMoneyTransaction(
      balance: Money(amount: int.parse(json["balance"]!)),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["dateTime"]!)),
      messageId: int.parse(json["messageId"]!),
      subject: json["subject"]!,
      phoneNumber: json["subjectPhoneNumber"]!,
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
      subject: subject,
      phoneNumber: phoneNumber,
      transactionAmount: transactionAmount,
      transactionCode: transactionCode,
      transactionCost: transactionCost,
      type: TransactionType.sendMoney,
    );
  }

  @override
  String toString() => toJson().toString();

  @override
  Widget toTransactionListItem(BuildContext context) {
    final amount = transactionAmount.amount.toString();
    return PrimaryItemCard(
      icon: const CircleAvatar(
        child: Text("S"),
      ),
      title: subject,
      subtitle: prettifyTimeDifference(dateTime),
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
  Widget toRichComponent(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: transactionCode, style: styledTransactionTextStyle),
      const TextSpan(text: "Confirmed.on "),
      TextSpan(text: dateTime.toString(), style: styledTransactionTextStyle),
      const TextSpan(text: ""),
    ]));
  }
}
