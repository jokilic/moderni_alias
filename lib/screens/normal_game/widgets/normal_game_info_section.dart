import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../models/team/team.dart';
import '../../../services/audio_record_service.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/animated_gesture_detector.dart';

class NormalGameInfoSection extends StatelessWidget {
  final Team currentlyPlayingTeam;
  final Function() showScores;
  final Function() exitGame;

  const NormalGameInfoSection({
    required this.currentlyPlayingTeam,
    required this.showScores,
    required this.exitGame,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 24),
        child: Stack(
          children: [
            Align(
              child: AnimatedColumn(
                fastAnimations: true,
                children: [
                  Text(
                    'currentlyPlayingTitle'.tr().toUpperCase(),
                    style: ModerniAliasTextStyles.playingTeamTitle,
                  ),
                  Text(
                    currentlyPlayingTeam.name,
                    textAlign: TextAlign.center,
                    style: ModerniAliasTextStyles.playingTeam,
                  ),
                  Consumer(
                    builder: (_, ref, __) {
                      final audioRecorderController = ref.watch(audioRecorderControllerProvider);

                      return AudioWaveforms(
                        recorderController: audioRecorderController,
                        size: Size(MediaQuery.sizeOf(context).width, 48),
                        padding: const EdgeInsets.symmetric(horizontal: 56),
                        waveStyle: const WaveStyle(
                          waveColor: ModerniAliasColors.whiteColor,
                          middleLineColor: ModerniAliasColors.whiteColor,
                          scaleFactor: 48,
                          extendWaveform: true,
                          showMiddleLine: false,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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
              right: 12,
              child: AnimatedGestureDetector(
                onTap: showScores,
                end: 0.8,
                child: const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.format_list_numbered_rounded,
                    color: ModerniAliasColors.whiteColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
