import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../../widgets/recording_waveform.dart';

class QuickGameInfoSection extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final AudioRecorder? recorder;
  final Function() exitGame;
  final Function() showScores;

  const QuickGameInfoSection({
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.recorder,
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
            child: IconButton(
              onPressed: null,
              icon: Image.asset(
                ModerniAliasIcons.wrong,
                color: ModerniAliasColors.white,
                height: 28,
                width: 28,
              ),
            ),
          ),
        ),
        if (recorder != null)
          RecordingWaveform(
            recorder: recorder!,
            padding: const EdgeInsets.symmetric(horizontal: 104),
          ),
        Positioned(
          right: 20,
          child: AnimatedGestureDetector(
            onTap: showScores,
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
