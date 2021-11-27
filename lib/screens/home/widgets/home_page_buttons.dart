import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './how_to_play_button.dart';
import '../../../constants/strings.dart';
import '../../../widgets/play_button.dart';
import '../../quick_game/quick_game_screen.dart';
import '../../start_game/start_game_screen.dart';

class HomePageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            PlayButton(
              text: startButtonString.toUpperCase(),
              horizontalPadding: 44,
              onPressed: () => Get.toNamed(
                StartGameScreen.routeName,
              ),
            ),
            const SizedBox(height: 25),
            PlayButton(
              text: quickStartButtonString.toUpperCase(),
              onPressed: () => Get.toNamed(
                QuickGameScreen.routeName,
              ),
            ),
            const SizedBox(height: 25),
            HowToPlayButton(),
            const SizedBox(height: 50),
          ],
        ),
      );
}
