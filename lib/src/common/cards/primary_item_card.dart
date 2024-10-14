import 'package:flutter/material.dart';

class PrimaryItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final Widget rightWidget;
  final VoidCallback onTap;

  const PrimaryItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.rightWidget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: icon,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: rightWidget,
      onTap: onTap,
    ));
  }
}
