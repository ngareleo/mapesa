import '../../utils/datetime.dart';
import '../../utils/money.dart';
import 'transaction.dart';

class LipaNaMpesaTransaction extends Transaction {
  final String subject;
  static const type = "lipa-na-mpesa";

  const LipaNaMpesaTransaction(
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
            transactionCost: const Money(amount: 0.0),
            dateTime: dateTime,
            balance: balance);

  factory LipaNaMpesaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return LipaNaMpesaTransaction(
        messageId: messageID,
        userId: "",
        transactionAmount: Money.fromString(message: match.group(2).toString()),
        transactionCode: match.group(1).toString(),
        dateTime: getDateTimeFromMessage(
            date: match.group(4).toString().trim(),
            time: match.group(5).toString().trim(),
            isAM: match.group(6).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(7).toString()),
        subject: match.group(3).toString());
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
      "subject": subject
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
