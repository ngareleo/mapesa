import 'package:flutter/material.dart';

class PrimaryItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final Widget rightWidget;
  final VoidCallback onTap;

  const PrimaryItemCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.rightWidget,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context)
            .size
            .width, // sets width to full width of screen),
        // sets height to full height of screen),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  rightWidget
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
