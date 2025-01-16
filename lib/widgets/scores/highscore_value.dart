import 'package:flutter/material.dart';

import '../../constants/text_styles.dart';

class HighscoreValue extends StatelessWidget {
  final String teamName;
  final String points;

  const HighscoreValue({
    required this.teamName,
    required this.points,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              teamName,
              style: ModerniAliasTextStyles.highscore,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            points,
            style: ModerniAliasTextStyles.highscore,
            textAlign: TextAlign.center,
          ),
        ],
      );
}
