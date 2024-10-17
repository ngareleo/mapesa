import 'package:flutter/material.dart';

import 'package:mapesa/src/features/model_mapper.dart';
import 'package:mapesa/src/features/simple_local_repository.dart';
import 'package:mapesa/src/models/transactions/transaction.dart';
import 'package:provider/provider.dart';

class DashboardPageV2 extends StatefulWidget {
  const DashboardPageV2({super.key});

  @override
  State<DashboardPageV2> createState() => _DashboardPageV2State();
}

class _DashboardPageV2State extends State<DashboardPageV2> {
  final _repository = SimpleLocalRepository.instance;
  final _mapper = CompactTransactionsMapper();
  List<Transaction>? _messages;

  @override
  void initState() {
    super.initState();
    _repository.refresh().then((_) => getMessagesFromLast3Months());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SimpleLocalRepository>(
      builder: (context, repo, child) => Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: SafeArea(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: repo.isFirstLoad()
                        ? renderLoadingIndicator(message: "Reading messages...")
                        : buildMessagesList(),
                  )))),
    );
  }

  Widget buildMessagesList() {
    return _messages != null
        ? Column(
            children: (_messages ?? [])
                .map((t) => t.toTransactionListItem(context))
                .toList(),
          )
        : renderLoadingIndicator(message: "Loading...");
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

  Future<void> getMessagesFromLast3Months() async {
    final messages = (await _repository.getMessagesFromLast3Months())
        .map((d) => _mapper.mapFromAToB(d))
        .whereType<Transaction>()
        .toList();

    setState(() {
      _messages = messages;
    });
  }
}
