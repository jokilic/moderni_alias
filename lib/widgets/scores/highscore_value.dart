import 'package:flutter/material.dart';

import '../../constants/text_styles.dart';

class HighscoreValue extends StatelessWidget {
  final String teamName;
  final int points;

  const HighscoreValue({
    required this.teamName,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width * 0.6,
              child: Text(
                teamName,
                style: ModerniAliasTextStyles.highscore,
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: width * 0.1,
              child: Text(
                points.toString(),
                textAlign: TextAlign.center,
                style: ModerniAliasTextStyles.highscore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}