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

  // Initialize isar: our local store
  final dir = await getApplicationDocumentsDirectory();
  // Initialize repositories: for fetching data
  final isar = await Isar.open([CompactTransactionSchema], directory: dir.path);

  // Local repositories
  FailedTransactionsRepository.init(isar);
  CompactTransactionsRepository.init(isar);

  // Search Provider
  SearchProvider.init(isar);
  // Initialize auth provider; for auth related
  await AuthProvider.init();
  // Initialize dio provider; our network manager
  // Needs AuthProvider to be initialized first
  await DioProvider.init();
  // Feature flags
  await FeatureFlagsProvider.init();
  // Local store
  await SimpleLocalRepository.init();
  ////////////////////////////////////////////////////
  //               Services                       //
  ///////////////////////////////////////////////////
  await MobileServerReconciliationProvider.init();
  ////////////////////////////////////////////////////
  //               Application                    //
  ///////////////////////////////////////////////////

  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider.instance, child: const MapesaApp()));
}
