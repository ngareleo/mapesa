import 'package:flutter/material.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

class TransactionInfoPageV2 extends StatefulWidget {
  final Transaction _transaction;

  const TransactionInfoPageV2(this._transaction, {super.key});

  @override
  State<TransactionInfoPageV2> createState() => _TransactionInfoPageV2State();
}

class _TransactionInfoPageV2State extends State<TransactionInfoPageV2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [Card()],
        ),
      ),
    );
  }
}
