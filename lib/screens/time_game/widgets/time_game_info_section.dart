import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../models/team/team.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/animated_gesture_detector.dart';

class TimeGameInfoSection extends StatelessWidget {
  final Team currentlyPlayingTeam;
  final Function() showScores;
  final Function() exitGame;

  const TimeGameInfoSection({
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
                  // TODO
                  // Consumer(
                  //   builder: (_, ref, __) {
                  //     final audioRecorderController = ref.watch(audioRecorderControllerProvider);

                  //     return AudioWaveforms(
                  //       recorderController: audioRecorderController,
                  //       size: Size(MediaQuery.sizeOf(context).width, 48),
                  //       padding: const EdgeInsets.symmetric(horizontal: 56),
                  //       waveStyle: const WaveStyle(
                  //         waveColor: ModerniAliasColors.white,
                  //         middleLineColor: ModerniAliasColors.white,
                  //         scaleFactor: 24,
                  //         extendWaveform: true,
                  //         showMiddleLine: false,
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
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
            Positioned(
              right: 12,
              child: AnimatedGestureDetector(
                onTap: showScores,
                end: 0.8,
                child: IconButton(
                  onPressed: null,
                  icon: Image.asset(
                    ModerniAliasIcons.listImage,
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
