import 'package:flutter/material.dart';
import 'package:mapesa/src/common/cards/primary_item_card.dart';
import 'package:mapesa/src/common/charts/comparison_bar.dart';

enum StoryType { widget, page }

class Story {
  final StoryType storyType;
  final Widget widget;
  final String label;

  Story({required this.label, required this.widget, required this.storyType});
}

List<Story> initStories(BuildContext context) => [
      Story(
          label: "primary_item_card",
          widget: PrimaryItemCard(
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
          storyType: StoryType.widget),
      Story(
          label: "comparison_bar",
          widget:
              const ComparisonBar(title: "Food", current: 12400, max: 20000),
          storyType: StoryType.widget)
    ];
