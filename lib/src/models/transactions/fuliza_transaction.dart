import '../../utils/money.dart';
import 'transaction.dart';

class FulizaTransaction extends Transaction {
  static const type = "fuliza";

  final Money interest;

  const FulizaTransaction(
      {required int messageId,
      required String userId,
      required Money transactionAmount,
      required String transactionCode,
      required Money balance,
      required this.interest})
      : super(
            messageId: messageId,
            userId: userId,
            transactionAmount: transactionAmount,
            transactionCode: transactionCode,
            transactionCost: null,
            dateTime: null,
            balance: balance);

  factory FulizaTransaction.fromMpesaMessage(
      {required int messageID, required RegExpMatch match}) {
    return FulizaTransaction(
        messageId: messageID,
        userId: "",
        transactionAmount:
            Money.fromString(message: match.group(2).toString().trim()),
        transactionCode: match.group(1).toString().trim(),
        interest: Money.fromString(message: match.group(3).toString().trim()),
        balance: Money.fromString(
            message: match.group(4).toString().trim(), isNegative: true));
  }

  @override
  Map<String, String?> toJson() {
    return {
      "type": type,
      "messageID": messageId.toString(),
      "userID": userId,
      "transactionAmount": transactionAmount?.amount.toString(),
      "transactionCode": transactionCode,
      "interest": interest.amount.toString(),
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
