import 'package:flutter_test/flutter_test.dart';
import 'package:mapesa/src/features/upload/mapper.dart';
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
  var mapper = Mapper();

  test("Mapper maps the airtime messages to right type", () {
    var transactionType =
        mapper.mapMessageToTransaction(message: airtimeMessage, messageID: 0);
    expect(transactionType is AirtimeTransaction, true);
  });

  test("Mapper maps the send money messages to right type", () {
    expect(
        mapper.mapMessageToTransaction(message: sendMoneyMessage, messageID: 0)
            is SendMoneyTransaction,
        true);
  });

  test("Mapper maps the paybill messages to right type", () {
    expect(
        mapper.mapMessageToTransaction(message: paybillMessage, messageID: 0)
            is PaybillTransaction,
        true);
  });

  test("Mapper maps the lipa na mpesa messages to right type", () {
    expect(
        mapper.mapMessageToTransaction(
            message: lipaNaMpesaMessage,
            messageID: 0) is LipaNaMpesaTransaction,
        true);
  });

  test("Mapper maps the withdraw money messages to right type", () {
    expect(
        mapper.mapMessageToTransaction(
            message: withdrawMoneyMessage, messageID: 0) is WithdrawTransaction,
        true);
  });

  test("Mapper maps the receive money messages to right type", () {
    expect(
        mapper.mapMessageToTransaction(
            message: receiveMoneyMessage,
            messageID: 0) is ReceiveMoneyTransaction,
        true);
  });

  test("Mapper maps the deposit money messages to right type", () {
    expect(
        mapper.mapMessageToTransaction(
            message: depositMoneyMessage, messageID: 0) is DepositTransaction,
        true);
  });

  test("Mapper maps the fuliza messages to right type", () {
    expect(
        mapper.mapMessageToTransaction(message: fulizaMessage, messageID: 0)
            is FulizaTransaction,
        true);
  });
}
