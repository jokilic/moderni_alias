import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './how_to_play_button.dart';
import '../../../widgets/play_button.dart';
import '../../quick_game/quick_game_screen.dart';
import '../../start_game/start_game_screen.dart';

class HomePageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            PlayButton(
              text: 'startButtonString'.tr.toUpperCase(),
              horizontalPadding: 44.w,
              onPressed: () => Get.toNamed(
                StartGameScreen.routeName,
              ),
            ),
            SizedBox(height: 25.h),
            PlayButton(
              text: 'quickStartButtonString'.tr.toUpperCase(),
              onPressed: () => Get.toNamed(
                QuickGameScreen.routeName,
              ),
            ),
            SizedBox(height: 25.h),
            HowToPlayButton(),
            SizedBox(height: 50.h),
          ],
        ),
      );
}
