import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../models/team/team.dart';
import '../../../widgets/animated_column.dart';

class MainGameInfoSection extends StatelessWidget {
  final Team currentlyPlayingTeam;
  final Function() showScores;
  final Function() exitGame;

  const MainGameInfoSection({
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
              child: IconButton(
                onPressed: exitGame,
                icon: Icon(
                  Icons.close,
                  color: ModerniAliasColors.whiteColor,
                  size: 30.r,
                ),
              ),
            ),
            Positioned(
              right: 12.w,
              child: IconButton(
                onPressed: showScores,
                icon: Icon(
                  Icons.format_list_numbered,
                  color: ModerniAliasColors.whiteColor,
                  size: 30.r,
                ),
              ),
            ),
          ],
        ),
      );
}
