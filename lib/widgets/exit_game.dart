import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './exit_game_button.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../screens/home/home_screen.dart';
import '../screens/main_game/main_game_screen.dart';
import '../screens/quick_game/quick_game_screen.dart';

Future<bool> exitGame(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 36,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            backgroundImage,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            exitModalQuestionString,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              const SizedBox(width: 24),
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
