import '../../utils/datetime.dart';
import '../../utils/money.dart';
import 'transaction.dart';

class DepositTransaction extends Transaction {
  final String location;
  static const type = "deposit";

  const DepositTransaction(
      {required int messageId,
      required String userId,
      required Money transactionAmount,
      required String transactionCode,
      required DateTime dateTime,
      required Money balance,
      required this.location})
      : super(
            messageId: messageId,
            userId: userId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: const Money(amount: 0),
            dateTime: dateTime,
            balance: balance);

  factory DepositTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return DepositTransaction(
        messageId: messageID,
        userId: "",
        transactionAmount:
            Money.fromString(message: match.group(5).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        dateTime: getDateTimeFromMessage(
            date: match.group(2).toString().trim(),
            time: match.group(3).toString().trim(),
            isAM: match.group(4).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(7).toString().trim()),
        location: match.group(6).toString().trim());
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
      "location": location,
      "balance": balance?.amount.toString()
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
