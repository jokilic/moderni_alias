import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../services/audio_record_service.dart';
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
                child: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(
                    ModerniAliasIcons.wrongImage,
                    colorFilter: const ColorFilter.mode(
                      ModerniAliasColors.white,
                      BlendMode.srcIn,
                    ),
                    height: 28,
                    width: 28,
                  ),
                ),
              ),
            ),
            Consumer(
              builder: (_, ref, __) {
                final audioRecorderController = ref.watch(audioRecorderControllerProvider);

                return AudioWaveforms(
                  recorderController: audioRecorderController,
                  size: Size(MediaQuery.sizeOf(context).width, 48),
                  padding: const EdgeInsets.symmetric(horizontal: 104),
                  waveStyle: const WaveStyle(
                    waveColor: ModerniAliasColors.white,
                    middleLineColor: ModerniAliasColors.white,
                    scaleFactor: 24,
                    extendWaveform: true,
                    showMiddleLine: false,
                  ),
                );
              },
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
