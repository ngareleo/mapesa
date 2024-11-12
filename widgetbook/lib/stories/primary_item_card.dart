import 'package:flutter/material.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:mapesa/src/common/cards/primary_item_card.dart';

@widgetbook.UseCase(name: 'Default', type: PrimaryItemCard)
Widget buildCoolButtonUseCase(BuildContext context) {
  return PrimaryItemCard(
      title: "Boha Cereals Shop",
      subtitle: "10 mins ago",
      icon: const CircleAvatar(child: Text("BC")),
      rightWidget: Text(
        "KES 100",
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      ),
      onTap: () {});
}
