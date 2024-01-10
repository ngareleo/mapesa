import 'package:flutter/material.dart';
import 'package:mapesa/src/features/cache/cache_items.dart';
import 'package:mapesa/src/features/cache/common_cache.dart';
import 'package:mapesa/src/features/sms_provider.dart';
import 'package:mapesa/src/pages/budget_page.dart';
import 'package:mapesa/src/pages/dashboard_page.dart';
import 'package:mapesa/src/pages/debug_page.dart';
import 'package:mapesa/src/pages/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _smsProvider = SMSProvider.instance;

  var _currentPageIndex = 0;

  @override
  void setState(VoidCallback fn) {
    _smsProvider.updateMessageLimit();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.donut_large_rounded),
            label: 'Budget',
          ),
          NavigationDestination(icon: Icon(Icons.adb_rounded), label: "Debug")
        ],
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      body: Center(
          child: <Widget>[
        const DashboardPage(),
        const SearchPage(),
        const BudgetPage(),
        const DebugPage()
      ][_currentPageIndex]),
    );
  }
}
