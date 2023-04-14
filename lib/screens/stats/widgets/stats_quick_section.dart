import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../localization.dart';
import '../../../models/quick_game_stats/quick_game_stats.dart';
import '../../../widgets/game_title.dart';
import '../../quick_game_stats/quick_game_stats_screen.dart';
import '../stats_controller.dart';
import 'stats_value_widget.dart';

class StatsQuickSection extends GetView<StatsController> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final sortedGames = List<QuickGameStats>.from(controller.quickGameStats)..sort((a, b) => a.startTime.difference(now).abs().compareTo(b.startTime.difference(now).abs()));

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// QUICK GAMES
        ///
        GameTitle(
          'statsGeneralQuickGames'.tr.toUpperCase(),
        ),

        SizedBox(height: 12.h),

        if (controller.quickGameStats.isEmpty)
          StatsValueWidget(
            text: 'statsQuickNoGames'.tr,
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.quickGameStats.length,
            itemBuilder: (_, index) {
              final quickGame = sortedGames[index];
              final time = DateFormat('d. MMMM - HH:mm', Localization.locale?.languageCode ?? 'en').format(quickGame.startTime);

              return StatsValueWidget(
                text: time,
                value: index + 1,
                valueLeft: true,
                onPressed: () => Get.toNamed(
                  QuickGameStatsScreen.routeName,
                  arguments: quickGame,
                ),
              );
            },
          ),
      ],
    );
  }
}
