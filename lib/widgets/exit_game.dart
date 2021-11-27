import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './exit_game_button.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../screens/home/home_screen.dart';
import '../screens/main_game/main_game_screen.dart';
import '../screens/quick_game/quick_game_screen.dart';

Future<bool> exitGame(BuildContext context) async {
  await Get.bottomSheet(
    Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 36.h,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
            backgroundImage,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            exitModalQuestionString,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExitGameButton(
                text: exitModalQuestionYes,
                onPressed: () {
                  gamePlaying = false;
                  simpleGamePlaying = false;
                  soundTimer?.cancel();
                  greenTimer?.cancel();
                  yellowTimer?.cancel();
                  redTimer?.cancel();
                  quickSoundTimer?.cancel();
                  countdownAudioPlayer.stop();
                  countdownQuickAudioPlayer.stop();
                  countdownTimerFillColor = darkBlueColor;

                  Get.offNamedUntil(
                    HomeScreen.routeName,
                    (route) => false,
                  );
                },
              ),
              SizedBox(width: 24.h),
              ExitGameButton(
                text: exitModalQuestionNo,
                onPressed: Get.back,
              ),
            ],
          ),
        ],
      ),
    ),
  );
  return true;
}
