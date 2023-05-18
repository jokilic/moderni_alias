import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../localization.dart';
import '../../../models/normal_game_stats/normal_game_stats.dart';
import '../../../widgets/game_title.dart';
import '../../normal_game_stats/normal_game_stats_screen.dart';
import '../stats_controller.dart';
import 'stats_value_widget.dart';

class StatsNormalSection extends GetView<StatsController> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final sortedGames = List<NormalGameStats>.from(controller.normalGameStats)..sort((a, b) => a.startTime.difference(now).abs().compareTo(b.startTime.difference(now).abs()));

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// NORMAL GAMES
        ///
        GameTitle(
          'statsGeneralNormalGames'.tr.toUpperCase(),
        ),

        const SizedBox(height: 12),

        if (controller.normalGameStats.isEmpty)
          StatsValueWidget(
            text: 'statsNormalNoGames'.tr,
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.normalGameStats.length,
            itemBuilder: (_, index) {
              final normalGame = sortedGames[index];
              final time = DateFormat('d. MMMM - HH:mm', Localization.locale?.languageCode ?? 'en').format(normalGame.startTime);
              final textTime = timeago.format(normalGame.startTime);

              return StatsValueWidget(
                text: '$time\n($textTime)',
                value: index + 1,
                valueLeft: true,
                onPressed: () => Get.toNamed(
                  NormalGameStatsScreen.routeName,
                  arguments: normalGame,
                ),
              );
            },
          ),
      ],
    );
  }
}
