import 'package:flutter/material.dart';
import 'package:mapesa/src/features/search_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

class SearchPageV2 extends StatefulWidget {
  const SearchPageV2({super.key});

  @override
  State<SearchPageV2> createState() => _SearchPageV2State();
}

class _SearchPageV2State extends State<SearchPageV2> {
  final _searchController = TextEditingController();
  final _search = SearchProvider.instance;
  var _suggestions = <Transaction>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                    hintText: "Search for MPESA transaction",
                    border: OutlineInputBorder(),
                    suffix: Icon(Icons.search)),
                onSubmitted: (value) => {debugPrint("Search $value")},
                onChanged: (value) async {
                  final suggestions = await _search.suggest(seed: value);
                  debugPrint("Suggestions $suggestions");
                  setState(() {
                    _suggestions = suggestions;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: _suggestions.isEmpty
                        ? [
                            const Card(
                              child: ListTile(
                                title: Text("Nothing to show"),
                              ),
                            )
                          ]
                        : _suggestions
                            .map((s) => s.toTransactionListItem())
                            .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
