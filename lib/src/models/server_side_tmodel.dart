import 'package:isar/isar.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/utils/money.dart';

@Collection()
class ServerSideTModel {
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
  final String? location;
  final Money? interest;

  @Name("transaction_amount")
  final Money transactionAmount;
  @Name("transaction_code")
  final String transactionCode;
  @Name("transaction_cost")
  final Money transactionCost;

  @Enumerated(EnumType.value, "serverSide")
  final TransactionType transactionType;

  const ServerSideTModel({
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
    required this.transactionType,
  });
}
