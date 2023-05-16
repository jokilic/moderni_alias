import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/game_service.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/play_button.dart';
import '../../start_game/start_game_screen.dart';
import 'statss_button.dart';

class HomePageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameService = Get.find<GameService>();

    return Center(
      child: AnimatedColumn(
        children: [
          PlayButton(
            text: 'startButtonString'.tr.toUpperCase(),
            horizontalPadding: 44,
            onPressed: () => Get.toNamed(
              StartGameScreen.routeName,
            ),
          ),
          const SizedBox(height: 25),
          PlayButton(
            text: 'quickStartButtonString'.tr.toUpperCase(),
            onPressed: gameService.startQuickGame,
          ),
          const SizedBox(height: 25),
          StatsButton(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
