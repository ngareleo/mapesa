import 'package:flutter/material.dart';
import 'package:mapesa/src/features/remote_service_provider.dart';
import 'package:mapesa/src/pages/m1/budget_page.dart';
import 'package:mapesa/src/pages/m1/dashboard_page.dart';
import 'package:mapesa/src/debug/debug_page.dart';
import 'package:mapesa/src/pages/m1/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentPageIndex = 0;

  @override
  void initState() {
    RemoteServiceProvider.instance.refresh();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
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
