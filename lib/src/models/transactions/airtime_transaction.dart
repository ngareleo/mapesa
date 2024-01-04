import '../../utils/datetime.dart';
import '../../utils/money.dart';
import 'transaction.dart';

class AirtimeTransaction extends Transaction {
  static const type = "airtime";

  const AirtimeTransaction({
    required int messageId,
    required String userId,
    required Money transactionAmount,
    required String transactionCode,
    required DateTime dateTime,
    required Money balance,
  }) : super(
            messageId: messageId,
            userId: userId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: const Money(amount: 0),
            dateTime: dateTime,
            balance: balance);

  factory AirtimeTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return AirtimeTransaction(
      messageId: messageID,
      userId: "",
      transactionAmount:
          Money.fromString(message: match.group(2).toString().trim()),
      transactionCode: match.group(1).toString().trim(),
      dateTime: getDateTimeFromMessage(
          date: match.group(3).toString().trim(),
          time: match.group(4).toString().trim(),
          isAM: match.group(5).toString().trim() == "AM"),
      balance: Money.fromString(message: match.group(6).toString().trim()),
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
      "balance": balance?.amount.toString()
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
