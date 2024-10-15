import 'package:flutter/material.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/types.dart';

Widget mapTransactionToRichTextComponent(Transaction transaction) {
  final mapper = CompactTransactionsMapper();
  final compact = mapper.mapFromBtoA(transaction);

  if (compact == null) {
    return const Text("Invalid");
  }

  return switch (compact.type) {
    TransactionType.airtime => const Text("Airtime"),
    _ => const Text("others")
  };
}
