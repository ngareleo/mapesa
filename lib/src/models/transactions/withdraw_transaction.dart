import '../../utils/datetime.dart';
import '../../utils/money.dart';
import 'transaction.dart';

class WithdrawTransaction extends Transaction {
  final String location;
  final String agentNumber;
  static const type = "withdraw";

  const WithdrawTransaction(
      {required int messageId,
      required String userId,
      required Money transactionAmount,
      required String transactionCode,
      required Money transactionCost,
      required DateTime dateTime,
      required Money balance,
      required this.location,
      required this.agentNumber})
      : super(
            messageId: messageId,
            userId: userId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: transactionCost,
            dateTime: dateTime,
            balance: balance);

  factory WithdrawTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return WithdrawTransaction(
        messageId: messageID,
        userId: "",
        transactionAmount:
            Money.fromString(message: match.group(5).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        transactionCost:
            Money.fromString(message: match.group(9).toString().trim()),
        dateTime: getDateTimeFromMessage(
            date: match.group(2).toString().trim(),
            time: match.group(3).toString().trim(),
            isAM: match.group(4).toString().trim() == "AM"),
        balance: Money.fromString(message: match.group(8).toString().trim()),
        location: match.group(7).toString().trim(),
        agentNumber: match.group(6).toString().trim());
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
      "location": location,
      "agentNumber": agentNumber
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
