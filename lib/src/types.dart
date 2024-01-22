import 'package:mapesa/src/models/transactions/airtime_for_transaction.dart';
import 'package:mapesa/src/models/transactions/airtime_transaction.dart';
import 'package:mapesa/src/models/transactions/deposit_transaction.dart';
import 'package:mapesa/src/models/transactions/fuliza_transaction.dart';
import 'package:mapesa/src/models/transactions/lipa_na_mpesa_transaction.dart';
import 'package:mapesa/src/models/transactions/paybill_transaction.dart';
import 'package:mapesa/src/models/transactions/receive_money_transaction.dart';
import 'package:mapesa/src/models/transactions/send_money_transaction.dart';
import 'package:mapesa/src/models/transactions/withdraw_transaction.dart';

typedef ListOfObjects = List<Map<String, String>>;
typedef ObjectMap = Map<String, String>;

enum TransactionType {
  receiveMoney(serverSide: "receive", clientSide: ReceiveMoneyTransaction.type),
  sendMoney(serverSide: "send", clientSide: SendMoneyTransaction.type),
  lipaNaMpesa(serverSide: "buygoods", clientSide: LipaNaMpesaTransaction.type),
  payBillMoney(serverSide: "paybill", clientSide: PaybillTransaction.type),
  airtime(serverSide: "airtime", clientSide: AirtimeTransaction.type),
  airtimeFor(serverSide: "airtime_for", clientSide: AirtimeForTransaction.type),
  withdrawMoney(serverSide: "withdraw", clientSide: WithdrawTransaction.type),
  fuliza(serverSide: "fuliza", clientSide: FulizaTransaction.type),
  depositMoney(serverSide: "deposit", clientSide: DepositTransaction.type);

  final String serverSide;
  final String clientSide;
  const TransactionType({required this.serverSide, required this.clientSide});
}
