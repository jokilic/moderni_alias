import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../models/team.dart';

class PlayingTeamInfo extends StatelessWidget {
  final Team currentlyPlayingTeam;
  final Function() showScores;
  final Function() exitGame;

  const PlayingTeamInfo({
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
              child: Column(
                children: [
                  Text(
                    'currentlyPlayingPlaceholder'.tr.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    currentlyPlayingTeam.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            Positioned(
              left: -10.w,
              top: -10.h,
              child: FlatButton(
                onPressed: exitGame,
                child: Icon(
                  Icons.close,
                  color: whiteColor,
                  size: 30.r,
                ),
              ),
            ),
            Positioned(
              right: -10.w,
              top: -10.h,
              child: FlatButton(
                onPressed: showScores,
                child: Icon(
                  Icons.format_list_numbered,
                  color: whiteColor,
                  size: 30.r,
                ),
              ),
            ),
          ],
        ),
      );
}
