import 'package:flutter/material.dart';
import 'package:mapesa/src/pages/budget.dart';
import 'package:mapesa/src/pages/dashboard.dart';
import 'package:mapesa/src/pages/debug.dart';
import 'package:mapesa/src/pages/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentPageIndex = 0;

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
