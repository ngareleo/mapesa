import 'package:flutter/material.dart';
import 'package:mapesa/src/features/search_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

class TransactionInfoPageV2 extends StatefulWidget {
  final Transaction transaction;

  const TransactionInfoPageV2(this.transaction, {super.key});

  @override
  State<TransactionInfoPageV2> createState() => _TransactionInfoPageV2State();
}

class _TransactionInfoPageV2State extends State<TransactionInfoPageV2> {
  final _search = SearchProvider.instance;
  final _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  var _suggestions = <Transaction>[];

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

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
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                child: MenuItemButton(
                  leadingIcon: const Icon(Icons.bug_report),
                  onPressed: () async {
                    await _showDebugDialog();
                  },
                  child: const Text('Debug'),
                ),
              )
            ],
            builder: (_, MenuController controller, Widget? child) {
              return IconButton(
                focusNode: _buttonFocusNode,
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.more_vert),
              );
            },
          )
        ],
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
                ..._suggestions.isEmpty
                    ? []
                    : [renderSuggestionsSection(context)]
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
          child: Column(
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

  Future<void> fetchSuggestions() async {
    final suggestions =
        await _search.suggestTransactions(transaction: widget.transaction);
    setState(() {
      _suggestions = suggestions;
    });
  }

  Future<void> _showDebugDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('AlertDialog Title'),
              content: Text(widget.transaction.toJson().toString()));
        });
  }
}
