import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../localization.dart';
import '../../../widgets/game_title.dart';
import '../../normal_game_stats/normal_game_stats_screen.dart';
import '../stats_controller.dart';
import 'stats_value_widget.dart';

class StatsNormalSection extends GetView<StatsController> {
  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ///
          /// NORMAL GAMES
          ///
          const GameTitle('NORMAL GAMES'),

          SizedBox(height: 12.h),

          if (controller.normalGameStats.isEmpty)
            const StatsValueWidget(
              text: "you haven't played any normal games yet",
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.normalGameStats.length,
              itemBuilder: (_, index) {
                final normalGame = controller.normalGameStats[index];
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
