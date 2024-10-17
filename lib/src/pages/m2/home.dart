import 'package:flutter/material.dart';

import 'package:mapesa/src/debug/debug_page.dart';
import 'package:mapesa/src/pages/m2/dashboard.dart';
import 'package:mapesa/src/pages/m2/search.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  var _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
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
            NavigationDestination(icon: Icon(Icons.adb_rounded), label: "Debug")
          ],
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
        body: [
          const DashboardPageV2(),
          const SearchPageV2(),
          const DebugPage()
        ][_currentPageIndex]);
  }
}
