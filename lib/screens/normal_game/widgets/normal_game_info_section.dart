import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../models/team/team.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../../widgets/recording_waveform.dart';

class NormalGameInfoSection extends StatelessWidget {
  final Team currentlyPlayingTeam;
  final AudioRecorder? recorder;
  final Function() showScores;
  final Function() exitGame;

  const NormalGameInfoSection({
    required this.currentlyPlayingTeam,
    required this.recorder,
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 56),
                child: Text(
                  currentlyPlayingTeam.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: ModerniAliasTextStyles.playingTeam,
                ),
              ),
              if (recorder != null)
                RecordingWaveform(
                  recorder: recorder!,
                  padding: const EdgeInsets.symmetric(horizontal: 56),
                ),
            ],
          ),
        ),
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
        Positioned(
          right: 12,
          child: AnimatedGestureDetector(
            onTap: showScores,
            child: IconButton(
              onPressed: null,
              icon: Image.asset(
                ModerniAliasIcons.list,
                color: ModerniAliasColors.white,
                height: 28,
                width: 28,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
