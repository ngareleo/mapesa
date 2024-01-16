import 'package:telephony/telephony.dart';

import 'package:mapesa/src/models/transactions/airtime_for_transaction.dart';
import 'package:mapesa/src/models/transactions/airtime_transaction.dart';
import 'package:mapesa/src/models/transactions/deposit_transaction.dart';
import 'package:mapesa/src/models/transactions/fuliza_transaction.dart';
import 'package:mapesa/src/models/transactions/lipa_na_mpesa_transaction.dart';
import 'package:mapesa/src/models/transactions/paybill_transaction.dart';
import 'package:mapesa/src/models/transactions/receive_money_transaction.dart';
import 'package:mapesa/src/models/transactions/send_money_transaction.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/models/transactions/withdraw_transaction.dart';

abstract class DataMapper<A, B> {
  // from [A] to [B]

  B? mapFromAToB(A from);
  A? mapFromBtoA(B from);
}

// This package is for converting data like sms into our local models

class TransactionsMapper extends DataMapper<SmsMessage, Transaction> {
  static final _patterns = {
    TransactionType.receiveMoney: RegExp(
        r'^(?:Congratulations!\s)?(\w{10})\s[Cc]onfirmed.You\shave\sreceived\sKsh(.+\.\d\d)\sfrom\s((.+)\s(\d*)\s|(.+)(\d*)\s)on\s(.*)\sat\s(.*)\s(PM|AM)\s*\.?New\sM-PESA\sbalance\sis\sKsh(\d\w{0,7}\.\d\d)\..*$'),
    TransactionType.sendMoney: RegExp(
        r'^(\w+)\sConfirmed.\sKsh(.+\.\d\d)\ssent\sto\s(.+)\s(\d+)\son\s(.+)\sat\s(.+)\s(PM|AM).\sNew\sM-PESA\sbalance\sis\sKsh(.+\.\d\d)\.\sTransaction\scost,\sKsh(\d\w{0,7}\.\d\d)\..*$'),
    TransactionType.lipaNaMpesa: RegExp(
        r'^(\w+)\sConfirmed.\sKsh(.+\.\d\d)\spaid\sto\s(.+)\.\son\s(.+)\sat (.+) (AM|PM).New M-PESA balance is Ksh(.+\.\d\d)\. Transaction cost, Ksh(\d\w{0,7}\.\d\d).*$'),
    TransactionType.payBillMoney: RegExp(
        r'^(\w{10})\sConfirmed\.\sKsh(.+\.\d\d)\ssent\sto\s(.+)\sfor\saccount\s(.*)\s?on(.{6,9})\sat\s(\d\d?:\d\d)\s(AM|PM)\.?\sNew\sM-PESA\sbalance\sis\sKsh(.+\.\d\d)\.\sTransaction\scost,\sKsh(.{1,3}\.\d\d?)\..*$'),
    TransactionType.airtime: RegExp(
        r'^(\w{10,12}) confirmed\.You bought Ksh(.+\.\d\d) of airtime on (.+) at (\d\d?:\d\d) (AM|PM)\.New M-PESA balance is Ksh(.+\.\d\d)\. Transaction cost, '),
    TransactionType.airtimeFor: RegExp(
        r'^(\w{10,12}) confirmed\.You bought Ksh(.+\.\d\d) of airtime for (.+?) on (.+) at (\d\d?:\d\d) (AM|PM)\.New balance is Ksh(.+\.\d\d)\. Transaction cost,'),
    TransactionType.withdrawMoney: RegExp(
        r'^(\w{0,12})\s[C,c]onfirmed.on\s(.{0,8})\sat\s(\d\d?:\d\d)\s(PM|AM)Withdraw\sKsh(.+\.\d\d)\sfrom\s(\d+)\s-\s(.+)\sNew\sM-PESA\sbalance\sis\sKsh(.+\.\d\d)\.\sTransaction\scost,\sKsh(\d\w{0,7}\.\d\d)\..*$'),
    TransactionType.fuliza: RegExp(
        r'^(\w{9,11})\s[Cc]onfirmed\.\sFuliza\sM-PESA\samount\sis\sKsh\s(.+\.\d{2})\.\sInterest charged Ksh (\d+\.\d{2})\.\sTotal\sFuliza\sM-PESA\soutstanding\samount\sis\sKsh\s(\d\w{0,7}\.\d\d)'),
    TransactionType.depositMoney: RegExp(
        r'^(\w{9,11}) Confirmed\. On (.{5,8}) at (.+) (PM|AM) Give Ksh(.+\.\d\d) cash to (.+) New M-PESA balance is Ksh(\d\w{0,7}\.\d\d)'),
  };

  static Map<TransactionType, RegExp> get transactionPatterns => _patterns;

  // Added the extra parameter to allow for testing
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
        FulizaTransaction.fromMpesaMessage(messageID: messageID, match: match),
      TransactionType.depositMoney =>
        DepositTransaction.fromMpesaMessage(messageID: messageID, match: match),
      TransactionType.airtimeFor => AirtimeForTransaction.fromMpesaMessage(
          messageID: messageID, match: match),
    };
  }
}
