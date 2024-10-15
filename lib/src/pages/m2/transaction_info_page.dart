import 'package:flutter/material.dart';

import 'package:mapesa/src/features/simple_local_repository.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

class TransactionInfoPageV2 extends StatefulWidget {
  final Transaction transaction;

  const TransactionInfoPageV2(this.transaction, {super.key});

  @override
  State<TransactionInfoPageV2> createState() => _TransactionInfoPageV2State();
}

class _TransactionInfoPageV2State extends State<TransactionInfoPageV2> {
  final _repository = SimpleLocalRepository.instance;
  var _suggestions = <Transaction>[];

  @override
  void initState() {
    super.initState();
    fetchSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Mpesa Message"),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_outline_rounded)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.copy_rounded))
                      ],
                    )
                  ],
                ),
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: widget.transaction.toRichComponent(context),
                )),
                Text(widget.transaction.toJson().toString()),
                renderSuggestionsSection(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderSuggestionsSection(BuildContext context) {
    final subject = widget.transaction.subject;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Other transactions with $subject"),
        const SizedBox(height: 10),
        SingleChildScrollView(
          child: Row(
            children: _suggestions
                .map((s) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: s.toTransactionListItem(context),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }

  void fetchSuggestions() async {
    final suggestions =
        await _repository.suggestTransactions(transaction: widget.transaction);
    debugPrint("Suggestions $suggestions");
    setState(() {
      _suggestions = suggestions;
    });
  }
}
