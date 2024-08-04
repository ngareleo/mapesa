import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:mapesa/src/common/theme.dart';
import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/features/dio_provider.dart';
import 'package:mapesa/src/features/repository/failed_transactions.dart';
import 'package:mapesa/src/features/up_to_date/utd_provider.dart';
import 'package:mapesa/src/models/server_side_tmodel.dart';
import 'package:mapesa/src/pages/auth_page.dart';
import 'package:mapesa/src/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  // Initialize isar: our local store
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([ServerSideTModelSchema], directory: dir.path);

  // Initialize repositories: for fetching data
  FailedTransactionsRepository.init(isar);

  // Initialize auth provider: for auth related
  await AuthProvider.init();

  // Initialize dio provider: our network manager
  // Needs AuthProvider to be initialized first
  await DioProvider.init();

  ////////////////////////////////////////////////////
  //               Services                       //
  ///////////////////////////////////////////////////

  // Initialize UTDProvider
  await UTDProvider.init();

  ////////////////////////////////////////////////////
  //               Application                    //
  ///////////////////////////////////////////////////

  // Start the app
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider.instance, child: const MapesaApp()));
}

////////////////////////////////////////////////////
//          Root UI Application                 //
///////////////////////////////////////////////////

class MapesaApp extends StatefulWidget {
  const MapesaApp({super.key});

  @override
  State<MapesaApp> createState() => _MapesaAppState();
}

class _MapesaAppState extends State<MapesaApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthProvider authProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mapesa',
        theme: appTheme,
        home: authProvider.isLoggedIn() ? const HomePage() : const AuthPage(),
      );
    });
  }
}
