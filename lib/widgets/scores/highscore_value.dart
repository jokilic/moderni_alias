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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: Text(
                teamName,
                style: ModerniAliasTextStyles.highscore,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                points,
                textAlign: TextAlign.center,
                style: ModerniAliasTextStyles.highscore,
              ),
            ),
          ],
        ),
      );
}
