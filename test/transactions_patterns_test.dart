import 'package:flutter_test/flutter_test.dart';
import 'package:mapesa/src/features/upload/patterns.dart';
import 'package:mapesa/src/models/transactions/airtime_transaction.dart';
import 'package:mapesa/src/models/transactions/deposit_transaction.dart';
import 'package:mapesa/src/models/transactions/fuliza_transaction.dart';
import 'package:mapesa/src/models/transactions/lipa_na_mpesa_transaction.dart';
import 'package:mapesa/src/models/transactions/paybill_transaction.dart';
import 'package:mapesa/src/models/transactions/receive_money_transaction.dart';
import 'package:mapesa/src/models/transactions/send_money_transaction.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/models/transactions/withdraw_transaction.dart';

import 'messages.dart';

void main() {
  Patterns patterns = const Patterns();

  test("Airtime pattern matches with message", () {
    var match = patterns.transactionPatterns[TransactionType.airtime]
        ?.firstMatch(airtimeMessage);
    // check if the regex pattern matches well
    expect(match == null, false);

    // check if object is represented well
    var airtimeTransaction =
        AirtimeTransaction.fromMpesaMessage(messageID: 0, match: match!);
    expect(airtimeTransaction.transactionCode, "RAM2Y3531G");
    expect(airtimeTransaction.transactionAmount?.amount, 200);
    expect(airtimeTransaction.balance?.amount, 855.51);
    expect(airtimeTransaction.dateTime, DateTime.parse("2023-01-23 12:09"));
  });

  test("Send Money pattern matches with message", () {
    var match = patterns.transactionPatterns[TransactionType.sendMoney]
        ?.firstMatch(sendMoneyMessage);
    // check if the regex pattern matches well
    expect(match == null, false);

    // check if object is represented well
    var sendMoneyTransaction =
        SendMoneyTransaction.fromMpesaMessage(messageID: 0, match: match!);
    expect(sendMoneyTransaction.transactionCode, "RAM2Y3531G");
    expect(sendMoneyTransaction.transactionAmount?.amount, 200.03);
    expect(sendMoneyTransaction.balance?.amount, 855.51);
    expect(sendMoneyTransaction.transactionCost?.amount, 4.00);
    expect(sendMoneyTransaction.phoneNumber, "078343443");
    expect(sendMoneyTransaction.subject, "WINFRED KANANA");
    expect(sendMoneyTransaction.dateTime, DateTime.parse("2023-01-23 00:09"));
  });

  test("Paybill Money pattern matches with message", () {
    var message =
        "RAM2Y3531G Confirmed. Ksh200.10 sent to WINFRED KANANA for account 078343443 on 23/1/23 at 7:09 PM New M-PESA balance is Ksh855.51. Transaction cost, Ksh4.01.";
    var match = patterns.transactionPatterns[TransactionType.payBillMoney]
        ?.firstMatch(message);
    // check if the regex pattern matches well
    expect(match == null, false);

    // check if object is represented well
    var paybillTransaction =
        PaybillTransaction.fromMpesaMessage(messageID: 0, match: match!);
    expect(paybillTransaction.subject, "WINFRED KANANA");
    expect(paybillTransaction.transactionCode, "RAM2Y3531G");
    expect(paybillTransaction.balance?.amount, 855.51);
    expect(paybillTransaction.subjectAccount, "078343443");
    expect(paybillTransaction.transactionAmount?.amount, 200.1);
    expect(paybillTransaction.transactionCost?.amount, 4.01);
    expect(paybillTransaction.dateTime, DateTime.parse("2023-01-23 19:09"));
  });

  test("Receive Money pattern matches with message", () {
    var match = patterns.transactionPatterns[TransactionType.receiveMoney]
        ?.firstMatch(receiveMoneyMessage);
    // check if the regex pattern matches well
    expect(match == null, false);

    // check if object is represented well
    var receiveMoneyTransaction =
        ReceiveMoneyTransaction.fromMpesaMessage(messageID: 0, match: match!);
    expect(receiveMoneyTransaction.subject, "WINFRED KANANA");
    expect(receiveMoneyTransaction.phoneNumber, "0783463443");
    expect(receiveMoneyTransaction.transactionAmount?.amount, 200.1);
    expect(receiveMoneyTransaction.balance?.amount, 855.51);
    expect(receiveMoneyTransaction.transactionCode, "RAM2Y3531G");
    expect(
        receiveMoneyTransaction.dateTime, DateTime.parse("2023-01-23 07:09"));
  });

  test("Lipa na mpesa pattern matches with message", () {
    var match = patterns.transactionPatterns[TransactionType.lipaNaMpesa]
        ?.firstMatch(lipaNaMpesaMessage);
    // check if the regex pattern matches well
    expect(match == null, false);

    // check if object is represented well
    var lipaNaMpesaTransaction =
        LipaNaMpesaTransaction.fromMpesaMessage(messageID: 0, match: match!);
    expect(lipaNaMpesaTransaction.subject, "WINFRED KANANA");
    expect(lipaNaMpesaTransaction.transactionCode, "RAM2Y3531G");
    expect(lipaNaMpesaTransaction.transactionCost?.amount, 0);
    expect(lipaNaMpesaTransaction.transactionAmount?.amount, 200.10);
    expect(lipaNaMpesaTransaction.balance?.amount, 855.51);
    expect(lipaNaMpesaTransaction.dateTime, DateTime.parse("2023-01-23 07:09"));
  });

  test("Withdraw money pattern matches with message", () {
    var match = patterns.transactionPatterns[TransactionType.withdrawMoney]
        ?.firstMatch(withdrawMoneyMessage);
    // check if the regex pattern matches well
    expect(match == null, false);

    // check if object is represented well
    var withdrawMoneyTransaction =
        WithdrawTransaction.fromMpesaMessage(messageID: 0, match: match!);
    expect(withdrawMoneyTransaction.transactionAmount?.amount, 200.10);
    expect(withdrawMoneyTransaction.transactionCost?.amount, 23.00);
    expect(withdrawMoneyTransaction.balance?.amount, 855.51);
    expect(withdrawMoneyTransaction.transactionCode, "RAM2Y3531G");
    expect(withdrawMoneyTransaction.location, "Fkam LTD");
    expect(withdrawMoneyTransaction.agentNumber, "4834545");
    expect(
        withdrawMoneyTransaction.dateTime, DateTime.parse("2023-01-23 19:09"));
  });

  test("Deposit money pattern matches with message", () {
    var match = patterns.transactionPatterns[TransactionType.depositMoney]
        ?.firstMatch(depositMoneyMessage);
    // check if the regex pattern matches well
    expect(match == null, false);

    // check if object is represented well
    var depositTransaction =
        DepositTransaction.fromMpesaMessage(messageID: 0, match: match!);
    expect(depositTransaction.location, "Fkam LTD");
    expect(depositTransaction.balance?.amount, 855.51);
    expect(depositTransaction.transactionAmount?.amount, 200.1);
    expect(depositTransaction.transactionCode, "RAM2Y3531G");
    expect(depositTransaction.dateTime, DateTime.parse("2023-01-23 19:09"));
  });

  test("Fuliza pattern matches with message", () {
    var match = patterns.transactionPatterns[TransactionType.fuliza]
        ?.firstMatch(fulizaMessage);
    // check if the regex pattern matches well
    expect(match == null, false);

    // check if object is represented well
    var fulizaTransaction =
        FulizaTransaction.fromMpesaMessage(messageID: 0, match: match!);
    expect(fulizaTransaction.transactionCode, "RAM2Y3531G");
    expect(fulizaTransaction.interest.amount, 0.6);
    expect(fulizaTransaction.transactionAmount?.amount, 90.1);
    expect(fulizaTransaction.balance?.amount, -90.39);
  });
}
