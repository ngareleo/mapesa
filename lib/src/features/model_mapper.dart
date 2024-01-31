import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

import 'package:mapesa/src/models/server_side_tmodel.dart';
import 'package:mapesa/src/models/transactions/fuliza_transaction.dart';
import 'package:mapesa/src/models/transactions/airtime_for_transaction.dart';
import 'package:mapesa/src/models/transactions/airtime_transaction.dart';
import 'package:mapesa/src/models/transactions/deposit_transaction.dart';
import 'package:mapesa/src/models/transactions/lipa_na_mpesa_transaction.dart';
import 'package:mapesa/src/models/transactions/paybill_transaction.dart';
import 'package:mapesa/src/models/transactions/receive_money_transaction.dart';
import 'package:mapesa/src/models/transactions/send_money_transaction.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/models/transactions/withdraw_transaction.dart';
import 'package:mapesa/src/types.dart';

abstract class DataMapper<A, B> {
  // from [A] to [B]

  B? mapFromAToB(A from);
  A? mapFromBtoA(B from);
}

// This package is for converting data like sms into our local models

class TransactionsMapper extends DataMapper<SmsMessage, Transaction> {
  static final _patterns = {
    TransactionType.airtime: AirtimeTransaction.regex,
    TransactionType.airtimeFor: AirtimeForTransaction.regex,
    TransactionType.depositMoney: DepositTransaction.regex,
    TransactionType.fuliza: FulizaTransaction.regex,
    TransactionType.lipaNaMpesa: LipaNaMpesaTransaction.regex,
    TransactionType.payBillMoney: PaybillTransaction.regex,
    TransactionType.receiveMoney: ReceiveMoneyTransaction.regex,
    TransactionType.sendMoney: SendMoneyTransaction.regex,
    TransactionType.withdrawMoney: WithdrawTransaction.regex,
  };

  static Map<TransactionType, RegExp> get transactionPatterns => _patterns;

  // Added the extra function call to allow for testing
  @override
  Transaction? mapFromAToB(SmsMessage from) {
    var SmsMessage(:id, :body) = from;
    return (body == null || id == null)
        ? null
        : mapStringToTransaction(body, id);
  }

  Transaction? mapStringToTransaction(String body, int id) {
    for (var map in _patterns.entries) {
      var transactionType = map.key;
      var expression = _patterns[transactionType];
      var isMatch = expression?.hasMatch(body);

      if (isMatch != null && expression != null && isMatch) {
        return getTransaction(
            transactionType, id, expression.firstMatch(body)!);
      }
    }

    debugPrint("Invalid transaction: $body");
    return null;
  }

  @override
  SmsMessage? mapFromBtoA(Transaction from) {
    throw UnimplementedError();
  }

  Transaction? getTransaction(
      TransactionType type, int messageID, RegExpMatch match) {
    return switch (type) {
      TransactionType.receiveMoney => ReceiveMoneyTransaction.fromMpesaMessage(
          messageID: messageID, match: match),
      TransactionType.sendMoney => SendMoneyTransaction.fromMpesaMessage(
          messageID: messageID, match: match),
      TransactionType.lipaNaMpesa => LipaNaMpesaTransaction.fromMpesaMessage(
          messageID: messageID, match: match),
      TransactionType.payBillMoney =>
        PaybillTransaction.fromMpesaMessage(messageID: messageID, match: match),
      TransactionType.airtime =>
        AirtimeTransaction.fromMpesaMessage(messageID: messageID, match: match),
      TransactionType.withdrawMoney => WithdrawTransaction.fromMpesaMessage(
          messageID: messageID, match: match),
      TransactionType.fuliza =>
        null, // TODO: Merge fuliza info with respective transactions
      TransactionType.depositMoney =>
        DepositTransaction.fromMpesaMessage(messageID: messageID, match: match),
      TransactionType.airtimeFor => AirtimeForTransaction.fromMpesaMessage(
          messageID: messageID, match: match),
    };
  }
}

class FailedTransactionsMapper extends DataMapper<ObjectMap, Transaction> {
  // TODO: Write tests for this
  @override
  Transaction? mapFromAToB(ObjectMap from) {
    var type = from["type"];
    if (type == null) return null;
    return switch (type) {
      "receiveMoney" => ReceiveMoneyTransaction.fromJson(from),
      "sendMoney" => SendMoneyTransaction.fromJson(from),
      "lipaNaMpesa" => LipaNaMpesaTransaction.fromJson(from),
      "payBillMoney" => PaybillTransaction.fromJson(from),
      "airtime" => AirtimeTransaction.fromJson(from),
      "withdrawMoney" => WithdrawTransaction.fromJson(from),
      "fuliza" => null, // TODO: Merge fuliza info with respective transactions
      "depositMoney" => DepositTransaction.fromJson(from),
      "airtime-for" => AirtimeForTransaction.fromJson(from),
      "invalid" => InvalidTransaction(),
      _ => null,
    };
  }

  @override
  ObjectMap? mapFromBtoA(Transaction from) {
    throw UnimplementedError();
  }
}

class ServerSideTModelMapper extends DataMapper<ServerSideTModel, Transaction> {
  // TODO: Write tests for this

  @override
  Transaction? mapFromAToB(ServerSideTModel from) {
    var type = from.type;
    return switch (type) {
      TransactionType.airtime => AirtimeTransaction.fromJson(from.toJson()),
      TransactionType.airtimeFor =>
        AirtimeForTransaction.fromJson(from.toJson()),
      TransactionType.depositMoney =>
        DepositTransaction.fromJson(from.toJson()),
      TransactionType.fuliza =>
        null, // TODO: Merge fuliza info with respective transactions
      TransactionType.lipaNaMpesa =>
        LipaNaMpesaTransaction.fromJson(from.toJson()),
      TransactionType.payBillMoney =>
        PaybillTransaction.fromJson(from.toJson()),
      TransactionType.receiveMoney =>
        ReceiveMoneyTransaction.fromJson(from.toJson()),
      TransactionType.sendMoney => SendMoneyTransaction.fromJson(from.toJson()),
      TransactionType.withdrawMoney =>
        WithdrawTransaction.fromJson(from.toJson()),
    };
  }

  @override
  ServerSideTModel? mapFromBtoA(Transaction from) {
    return from.toServerSideTModel();
  }
}
