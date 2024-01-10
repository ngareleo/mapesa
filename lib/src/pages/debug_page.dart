import 'package:flutter/material.dart';
import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/common/charts/comparison_bar.dart';
import 'package:mapesa/src/features/auth_provider.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<StatefulWidget> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug")),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context)
              .size
              .width, // sets width to full width of screen),
          height: MediaQuery.of(context)
              .size
              .height, // sets height to full height of screen),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryItemCard(
                    title: "Boha Cereals Shop",
                    subtitle: "10 mins ago",
                    icon: const CircleAvatar(child: Text("BC")),
                    rightWidget: Text(
                      "KES 100",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {}),
                const ComparisonBar(title: "Food", current: 12400, max: 20000),
                FilledButton(
                    onPressed: () async {
                      await AuthProvider.instance.logoutUser();
                    },
                    child: const Text("Logout"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
