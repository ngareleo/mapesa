import 'package:flutter/material.dart';

import 'package:mapesa/src/debug/ui_stories.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<StatefulWidget> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    var stories = initStories(context);
    var widgets = stories.map((s) {
      if (s.storyType == StoryType.widget) {
        return s.widget;
      } else {
        return generateStoryPageLink(s);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Debug")),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widgets,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget generateStoryPageLink(Story story) {
    return TextButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => PageStoryWrapper(story))),
        child: Text(story.label));
  }
}

class PageStoryWrapper extends StatelessWidget {
  final Story story;

  const PageStoryWrapper(
    this.story, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(story.label)),
      body: SafeArea(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: story.widget),
      ),
    );
    ;
  }
}
