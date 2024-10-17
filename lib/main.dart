import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:mapesa/src/debug/developer_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/features/search_provider.dart';
import 'package:mapesa/src/features/local_repository.dart';
import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/features/dio_provider.dart';
import 'package:mapesa/src/features/failed_transactions_repository.dart';
import 'package:mapesa/src/features/remote_service_provider.dart';
import 'package:mapesa/src/models/compact_transaction.dart';
import 'package:mapesa/src/mapesa_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  /////////////////////////////////////////////////////|
  //               Storage                            /|
  /////////////////////////////////////////////////////|
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    CompactTransactionSchema,
  ], directory: dir.path);
  FailedTransactionsRepository.init(isar);
  await LocalRepository.init(isar);
  //////////////////////////////////////////////////////|
  //               Boot dependencies                   /|
  //                                                   /|
  // Order matters. Check the dependency to know order /|
  //////////////////////////////////////////////////////|
  SearchProvider.init(isar);
  await AuthProvider.init();
  await DioProvider.init();
  await FeatureFlagsProvider.init();
  DeveloperProvider.init(isar);
  //////////////////////////////////////////////////////|
  //               Long-running services               /|
  //////////////////////////////////////////////////////|
  await RemoteServiceProvider.init();
  //////////////////////////////////////////////////////|
  //               Application                         /|
  //////////////////////////////////////////////////////|
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider.instance),
    ChangeNotifierProvider(create: (context) => LocalRepository.instance)
  ], child: const MapesaApp()));
}
