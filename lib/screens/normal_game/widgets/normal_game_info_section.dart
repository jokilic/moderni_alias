import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../models/team/team.dart';
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
        margin: EdgeInsets.only(top: 24.h),
        child: Stack(
          children: [
            Align(
              child: AnimatedColumn(
                fastAnimations: true,
                children: [
                  Text(
                    'currentlyPlayingTitle'.tr.toUpperCase(),
                    style: ModerniAliasTextStyles.playingTeamTitle,
                  ),
                  Text(
                    currentlyPlayingTeam.name,
                    textAlign: TextAlign.center,
                    style: ModerniAliasTextStyles.playingTeam,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 12.w,
              child: AnimatedGestureDetector(
                onTap: exitGame,
                end: 0.8,
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.close_rounded,
                    color: ModerniAliasColors.whiteColor,
                    size: 30.r,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12.w,
              child: AnimatedGestureDetector(
                onTap: showScores,
                end: 0.8,
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.format_list_numbered_rounded,
                    color: ModerniAliasColors.whiteColor,
                    size: 30.r,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
