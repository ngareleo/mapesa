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
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
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
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
