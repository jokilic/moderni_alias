import 'package:flutter/material.dart';

import '../../../constants/text_styles.dart';

class StatsTextIconWidget extends StatelessWidget {
  final String text;
  final String? icon;
  final double size;

  const StatsTextIconWidget({
    required this.text,
    this.icon,
    this.size = 68,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: ModerniAliasTextStyles.stats,
          ),
        ),
        const SizedBox(width: 28),
        if (icon != null)
          Image.asset(
            icon!,
            width: size,
          ),
      ],
    ),
  );
}
