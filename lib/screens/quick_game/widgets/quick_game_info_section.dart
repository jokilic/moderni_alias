import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_gesture_detector.dart';

class QuickGameInfoSection extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final Function() exitGame;
  final Function() showScores;

  const QuickGameInfoSection({
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.exitGame,
    required this.showScores,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        margin: const EdgeInsets.only(top: 24),
        child: Stack(
          children: [
            Positioned(
              left: 12,
              child: AnimatedGestureDetector(
                onTap: exitGame,
                end: 0.8,
                child: const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.close_rounded,
                    color: ModerniAliasColors.whiteColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              child: AnimatedGestureDetector(
                onTap: showScores,
                end: 0.8,
                child: Row(
                  children: [
                    Text(
                      wrongAnswers.toString(),
                      style: ModerniAliasTextStyles.quickWrongScore,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      correctAnswers.toString(),
                      style: ModerniAliasTextStyles.quickCorrectScore,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
