import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../widgets/animated_column.dart';
import '../../../widgets/play_button.dart';
import '../../start_game/start_game_screen.dart';
import 'statss_button.dart';

class HomePageButtons extends StatelessWidget {
  void goToStartGame(BuildContext context) => Navigator.of(context).pushNamed(
        StartGameScreen.routeName,
      );

  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedColumn(
          children: [
            PlayButton(
              text: 'startButtonString'.tr().toUpperCase(),
              horizontalPadding: 44,
              onPressed: () => goToStartGame(context),
            ),
            const SizedBox(height: 25),
            PlayButton(
              text: 'quickStartButtonString'.tr().toUpperCase(),
              onPressed: gameService.startQuickGame,
            ),
            const SizedBox(height: 25),
            StatsButton(),
            const SizedBox(height: 50),
          ],
        ),
      );
}
