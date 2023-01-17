import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './how_to_play_button.dart';
import '../../../services/game_service.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/play_button.dart';
import '../../start_game/start_game_screen.dart';

class HomePageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameService = Get.find<GameService>();

    return Center(
      child: AnimatedColumn(
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
            onPressed: gameService.startQuickGame,
          ),
          SizedBox(height: 25.h),
          HowToPlayButton(),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
