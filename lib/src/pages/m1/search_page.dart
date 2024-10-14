import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final messages = <SmsMessage>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Page")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(messages.length,
                    (index) => Text(messages[index].body ?? "No message")),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
