import 'package:flutter/material.dart';
import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

typedef ManyFutureTransactions = Future<List<Transaction>>;

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  final smsMapper = TransactionsMapper();
  late ManyFutureTransactions messages;

  @override
  void initState() {
    super.initState();
    messages = getMessagesFromLast3Months();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: buildMessagesList())));
  }

  ManyFutureTransactions getMessagesFromLast3Months() async {
    var msgs = await SMSProvider.instance.fetchRecentMessages();
    return msgs
        .map((m) => smsMapper.mapFromAToB(m))
        .whereType<Transaction>()
        .toList();
  }

  Widget buildMessagesList() {
    return FutureBuilder(
        future: messages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: (snapshot.data ?? [])
                  .map((d) => d.toTransactionListItem())
                  .toList(),
            );
          }
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: CircularProgressIndicator(),
              ),
              Text("Reading messages")
            ],
          );
        });
  }
}
