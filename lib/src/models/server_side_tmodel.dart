import 'package:isar/isar.dart';
import 'package:mapesa/src/types.dart';
import 'package:mapesa/src/utils/money.dart';

part 'server_side_tmodel.g.dart';

@Collection()
class ServerSideTModel {
  // Client side repr of the server side transaction
  final Id id = Isar.autoIncrement;
  final Money balance;
  final DateTime dateTime;

  @Name("message_id")
  final int messageId;
  final String subject;

  @Name("subject_phone_number")
  final String? phoneNumber;

  @Name("subject_account")
  final String? subjectAccount;
  @Name("agent_number")
  final String? agentNumber;
  final String? location;
  final Money? interest;

  @Name("transaction_amount")
  final Money transactionAmount;
  @Name("transaction_code")
  final String transactionCode;
  @Name("transaction_cost")
  final Money transactionCost;

  @Enumerated(EnumType.value, "serverSide")
  final TransactionType type;

  const ServerSideTModel({
    this.agentNumber,
    required this.balance,
    required this.dateTime,
    this.interest,
    this.location,
    required this.messageId,
    this.phoneNumber,
    required this.subject,
    this.subjectAccount,
    required this.transactionAmount,
    required this.transactionCode,
    required this.transactionCost,
    required this.type,
  });

  ObjectMap toJson() => {
        "agentNumber": agentNumber.toString(),
        "balance": balance.toString(),
        "dateTime": dateTime.millisecondsSinceEpoch.toString(),
        "interest": interest!.amount.toString(),
        "location": location.toString(),
        "messageId": messageId.toString(),
        "phoneNumber": phoneNumber.toString(),
        "subject": subject,
        "subjectAccount": subjectAccount.toString(),
        "transactionAmount": transactionAmount.amount.toString(),
        "transactionCode": transactionCode,
        "transactionCost": transactionCost.amount.toString(),
        "type": type.toString(),
      };
}
