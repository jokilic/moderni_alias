import 'package:flutter/material.dart';

import '../../../constants/text_styles.dart';

class StatsTextIconWidget extends StatelessWidget {
  final String text;
  final String? icon;
  final double size;

  const StatsTextIconWidget({
    required this.text,
    this.icon,
    this.size = 64,
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
        if (icon != null) ...[
          const SizedBox(width: 24),
          Image.asset(
            icon!,
            height: size,
            width: size,
          ),
        ],
      ],
    ),
  );
}
