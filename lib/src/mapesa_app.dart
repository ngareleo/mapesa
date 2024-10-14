import 'package:flutter/material.dart';
import 'package:mapesa/src/common/theme.dart';
import 'package:mapesa/src/debug/debug_page.dart';
import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/pages/auth_page.dart';
import 'package:mapesa/src/pages/home_page.dart';
import 'package:provider/provider.dart';

class MapesaApp extends StatelessWidget {
  const MapesaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mapesaM1Enabled =
        FeatureFlagsProvider.client.hasCachedFeatureFlag(Flags.NEW_MAPESA_M1);

    return Consumer(builder: (context, AuthProvider authProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mapesa',
        theme: appTheme,
        home: mapesaM1Enabled
            ? const DebugPage()
            : authProvider.isLoggedIn()
                ? const HomePage()
                : const AuthPage(),
      );
    });
  }
}
