import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/features/repository/compact_transactions.dart';
import 'package:mapesa/src/features/search_provider.dart';
import 'package:mapesa/src/features/simple_local_repository.dart';
import 'package:mapesa/src/mapesa_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/features/dio_provider.dart';
import 'package:mapesa/src/features/repository/failed_transactions.dart';
import 'package:mapesa/src/features/mobile_server_reconciliation_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  ////////////////////////////////////////////////////
  //               Storage                       //
  ///////////////////////////////////////////////////
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([CompactTransactionSchema], directory: dir.path);
  FailedTransactionsRepository.init(isar);
  CompactTransactionsRepository.init(isar);

  ///////////////////////////////////////////////////////
  //               Boot dependencies                   //
  //                                                   //
  // Order matters. Check the dependency to know order //
  ///////////////////////////////////////////////////////
  SearchProvider.init(isar);
  await AuthProvider.init();
  await DioProvider.init();
  await FeatureFlagsProvider.init();
  await SimpleLocalRepository.init();
  ////////////////////////////////////////////////////
  //               Long-running services            //
  ///////////////////////////////////////////////////
  await MobileServerReconciliationProvider.init();
  ////////////////////////////////////////////////////
  //               Application                    //
  ///////////////////////////////////////////////////
  runApp(ChangeNotifierProvider(
      create: (context) {
        AuthProvider.instance;
      },
      child: const MapesaApp()));
}
