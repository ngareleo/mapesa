import 'package:flutter/material.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:mapesa/src/pages/m2/components/transactions_rich_text_component.dart';

class TransactionInfoPageV2 extends StatefulWidget {
  final Transaction transaction;

  const TransactionInfoPageV2(this.transaction, {super.key});

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
      appBar: AppBar(
        title: const Text("Info"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Card(
                    child:
                        mapTransactionToRichTextComponent(widget.transaction))
              ],
            ),
          ),
        ),
      ),
    );
  }
}