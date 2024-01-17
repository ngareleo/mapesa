import 'package:flutter_test/flutter_test.dart';

import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/models/transactions/airtime_transaction.dart';
import 'package:mapesa/src/models/transactions/deposit_transaction.dart';
import 'package:mapesa/src/models/transactions/fuliza_transaction.dart';
import 'package:mapesa/src/models/transactions/lipa_na_mpesa_transaction.dart';
import 'package:mapesa/src/models/transactions/paybill_transaction.dart';
import 'package:mapesa/src/models/transactions/receive_money_transaction.dart';
import 'package:mapesa/src/models/transactions/send_money_transaction.dart';
import 'package:mapesa/src/models/transactions/withdraw_transaction.dart';

import 'messages.dart';

void main() {
  test("Airtime pattern matches with message", () {
    // check if object is represented well
    var airtimeTransaction = TransactionsMapper()
        .mapStringToTransaction(airtimeMessage, 0)! as AirtimeTransaction;
    expect(airtimeTransaction.transactionCode, "RAM2Y3531G");
    expect(airtimeTransaction.transactionAmount.amount, 20000);
    expect(airtimeTransaction.balance.amount, 85551);
    expect(airtimeTransaction.dateTime, DateTime.parse("2023-01-23 12:09"));
  });

  test("Send Money pattern matches with message", () {
    var sendMoneyTransaction = TransactionsMapper()
        .mapStringToTransaction(sendMoneyMessage, 0)! as SendMoneyTransaction;
    expect(sendMoneyTransaction.transactionCode, "RAM2Y3531G");
    expect(sendMoneyTransaction.transactionAmount.amount, 20003);
    expect(sendMoneyTransaction.balance.amount, 85551);
    expect(sendMoneyTransaction.transactionCost.amount, 400);
    expect(sendMoneyTransaction.phoneNumber, "078343443");
    expect(sendMoneyTransaction.subject, "WINFRED KANANA");
    expect(sendMoneyTransaction.dateTime, DateTime.parse("2023-01-23 00:09"));
  });

  test("Paybill Money pattern matches with message", () {
    var message =
        "RAM2Y3531G Confirmed. Ksh200.10 sent to WINFRED KANANA for account 078343443 on 23/1/23 at 7:09 PM New M-PESA balance is Ksh855.51. Transaction cost, Ksh4.01.";
    var paybillTransaction = TransactionsMapper()
        .mapStringToTransaction(message, 0)! as PaybillTransaction;
    expect(paybillTransaction.subject, "WINFRED KANANA");
    expect(paybillTransaction.transactionCode, "RAM2Y3531G");
    expect(paybillTransaction.balance.amount, 85551);
    expect(paybillTransaction.subjectAccount, "078343443");
    expect(paybillTransaction.transactionAmount.amount, 2001);
    expect(paybillTransaction.transactionCost.amount, 401);
    expect(paybillTransaction.dateTime, DateTime.parse("2023-01-23 19:09"));
  });

  test("Receive Money pattern matches with message", () {
    var receiveMoneyTransaction =
        TransactionsMapper().mapStringToTransaction(receiveMoneyMessage, 0)!
            as ReceiveMoneyTransaction;
    expect(receiveMoneyTransaction.subject, "WINFRED KANANA");
    expect(receiveMoneyTransaction.phoneNumber, "0783463443");
    expect(receiveMoneyTransaction.transactionAmount.amount, 20010);
    expect(receiveMoneyTransaction.balance.amount, 85551);
    expect(receiveMoneyTransaction.transactionCode, "RAM2Y3531G");
    expect(
        receiveMoneyTransaction.dateTime, DateTime.parse("2023-01-23 07:09"));
  });

  test("Lipa na mpesa pattern matches with message", () {
    var lipaNaMpesaTransaction =
        TransactionsMapper().mapStringToTransaction(lipaNaMpesaMessage, 0)!
            as LipaNaMpesaTransaction;
    expect(lipaNaMpesaTransaction.subject, "WINFRED KANANA");
    expect(lipaNaMpesaTransaction.transactionCode, "RAM2Y3531G");
    expect(lipaNaMpesaTransaction.transactionCost.amount, 0);
    expect(lipaNaMpesaTransaction.transactionAmount.amount, 20010);
    expect(lipaNaMpesaTransaction.balance.amount, 85551);
    expect(lipaNaMpesaTransaction.dateTime, DateTime.parse("2023-01-23 07:09"));
  });

  test("Withdraw money pattern matches with message", () {
    var withdrawMoneyTransaction =
        TransactionsMapper().mapStringToTransaction(withdrawMoneyMessage, 0)!
            as WithdrawTransaction;
    expect(withdrawMoneyTransaction.transactionAmount.amount, 20010);
    expect(withdrawMoneyTransaction.transactionCost.amount, 2300);
    expect(withdrawMoneyTransaction.balance.amount, 85551);
    expect(withdrawMoneyTransaction.transactionCode, "RAM2Y3531G");
    expect(withdrawMoneyTransaction.location, "Fkam LTD");
    expect(withdrawMoneyTransaction.agentNumber, "4834545");
    expect(
        withdrawMoneyTransaction.dateTime, DateTime.parse("2023-01-23 19:09"));
  });

  test("Deposit money pattern matches with message", () {
    var depositTransaction = TransactionsMapper()
        .mapStringToTransaction(depositMoneyMessage, 0)! as DepositTransaction;
    expect(depositTransaction.location, "Fkam LTD");
    expect(depositTransaction.balance.amount, 85551);
    expect(depositTransaction.transactionAmount.amount, 20010);
    expect(depositTransaction.transactionCode, "RAM2Y3531G");
    expect(depositTransaction.dateTime, DateTime.parse("2023-01-23 19:09"));
  });

  test("Fuliza pattern matches with message", () {
    var fulizaTransaction = TransactionsMapper()
        .mapStringToTransaction(fulizaMessage, 0)! as FulizaTransaction;
    expect(fulizaTransaction.transactionCode, "RAM2Y3531G");
    expect(fulizaTransaction.interest.amount, 0.6);
    expect(fulizaTransaction.transactionAmount.amount, 9010);
    expect(fulizaTransaction.balance.amount, -9039);
  });
}
