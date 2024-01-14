import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/features/cache/common_cache.dart';
import 'package:provider/provider.dart';
import 'package:mapesa/src/common/theme.dart';
import 'package:mapesa/src/pages/auth_page.dart';

import 'src/pages/home_page.dart';

void main() async {
  await dotenv.load();
  CommonCache();
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider.instance, child: const MapesaApp()));
}

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
        title: 'Flutter Demo',
        theme: appTheme,
        home: authProvider.isLoggedIn() ? const HomePage() : const AuthPage(),
      );
    });
  }
}
