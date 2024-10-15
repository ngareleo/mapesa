import 'package:flutter/material.dart';

import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

typedef ManyFutureTransactions = Future<List<Transaction>>;

class DashboardPageV2 extends StatefulWidget {
  const DashboardPageV2({super.key});

  @override
  State<DashboardPageV2> createState() => _DashboardPageV2State();
}

class _DashboardPageV2State extends State<DashboardPageV2> {
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
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: SafeArea(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: buildMessagesList(),
                ))));
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
                  .map((d) => d.toTransactionListItem(context))
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
