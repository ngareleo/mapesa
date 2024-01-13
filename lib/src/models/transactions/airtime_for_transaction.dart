import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import '../transactions/airtime_transaction.dart';

class AirtimeForTransaction extends AirtimeTransaction {
  final String subject;
  static const type = "airtime-for";

  AirtimeForTransaction(
      {required super.messageId,
      required super.userId,
      required super.transactionAmount,
      required super.transactionCode,
      required super.dateTime,
      required super.balance,
      required this.subject});

  factory AirtimeForTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return AirtimeForTransaction(
      messageId: messageID,
      userId: "",
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
  Map<String, String?> toJson() {
    return {
      "type": type,
      "messageId": messageId.toString(),
      "transactionAmount": transactionAmount?.amount.toString(),
      "transactionCode": transactionCode,
      "transactionCost": transactionCost?.amount.toString(),
      "dateTime": dateTime.toString(),
      "subject": subject,
      "balance": balance?.amount.toString()
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
