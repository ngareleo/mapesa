import '../../utils/datetime.dart';
import '../../utils/money.dart';
import 'transaction.dart';

class PaybillTransaction extends Transaction {
  final String subject;
  final String subjectAccount;
  static const type = "paybill";

  const PaybillTransaction(
      {required int messageId,
      required String userId,
      required Money transactionAmount,
      required String transactionCode,
      required Money transactionCost,
      required DateTime dateTime,
      required Money balance,
      required this.subjectAccount,
      required this.subject})
      : super(
            messageId: messageId,
            userId: userId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: transactionCost,
            dateTime: dateTime,
            balance: balance);

  factory PaybillTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return PaybillTransaction(
        messageId: messageID,
        userId: "",
        transactionAmount:
            Money.fromString(message: match.group(2).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        transactionCost:
            Money.fromString(message: match.group(9).toString().trim()),
        dateTime: getDateTimeFromMessage(
            date: match.group(5).toString().trim(),
            time: match.group(6).toString().trim(),
            isAM: match.group(7).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(8).toString().trim()),
        subject: match.group(3).toString().trim(),
        subjectAccount: match.group(4).toString().trim());
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
      "balance": balance?.amount.toString(),
      "subject": subject,
      "subjectAccount": subjectAccount
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
