import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';

class NormalGameStatsScreen extends StatelessWidget {
  static const routeName = '/normal-game-stats-screen';

  @override
  Widget build(BuildContext context) {
    final normalGame = Get.arguments as NormalGameStats;

    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 32.h),
                const HeroTitle(smallText: 'Game'),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
