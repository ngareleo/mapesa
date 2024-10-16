import 'package:flutter/material.dart';

import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/simple_local_repository.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';

typedef ManyFutureTransactions = Future<List<CompactTransaction>>;

class DashboardPageV2 extends StatefulWidget {
  const DashboardPageV2({super.key});

  @override
  State<DashboardPageV2> createState() => _DashboardPageV2State();
}

class _DashboardPageV2State extends State<DashboardPageV2> {
  var _isFirstLoad = true;
  final _repository = SimpleLocalRepository.instance;
  final _mapper = CompactTransactionsMapper();
  late ManyFutureTransactions _messages;

  @override
  void initState() {
    super.initState();
    checkIsFirstEverLoad().then((_) => getMessagesFromLast3Months());
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
                  child: _isFirstLoad
                      ? renderLoadingIndicator(message: "Reading messages...")
                      : buildMessagesList(),
                ))));
  }

  Widget buildMessagesList() {
    return FutureBuilder(
        future: _messages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: (snapshot.data ?? [])
                  .map((d) => _mapper.mapFromAToB(d))
                  .whereType<Transaction>()
                  .map((t) => t.toTransactionListItem(context))
                  .toList(),
            );
          }

          return renderLoadingIndicator(message: "Loading...");
        });
  }

  Widget renderLoadingIndicator({required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CircularProgressIndicator(),
          ),
          Text(message)
        ],
      ),
    );
  }

  void getMessagesFromLast3Months() {
    final messages = (_repository.getMessagesFromLast3Months());
    setState(() {
      _messages = messages;
    });
  }

  Future<void> checkIsFirstEverLoad() async {
    final isFirstLoad = await _repository.isFirstLoad();
    debugPrint("Is first load? $isFirstLoad");
    setState(() {
      _isFirstLoad = isFirstLoad;
    });
  }
}
