import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import '../transactions/airtime_transaction.dart';

class AirtimeForTransaction extends AirtimeTransaction {
  final String subject;
  static const type = "airtime-for";

  AirtimeForTransaction(
      {required int messageId,
      required String userId,
      required Money transactionAmount,
      required String transactionCode,
      required DateTime dateTime,
      required Money balance,
      required this.subject})
      : super(
            messageId: messageId,
            userId: userId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            dateTime: dateTime,
            balance: balance);

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
      "messageID": messageId.toString(),
      "userID": userId,
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
