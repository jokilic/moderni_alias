import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/game_title.dart';
import '../stats_controller.dart';
import 'stats_value_widget.dart';

class StatsGeneralSection extends GetView<StatsController> {
  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ///
          /// GENERAL
          ///
          const GameTitle(
            'Total games played',
            smallTitle: true,
          ),

          SizedBox(height: 12.h),

          StatsValueWidget(
            text: 'Normal games',
            value: controller.totalNormalGames,
          ),
          StatsValueWidget(
            text: 'Quick games',
            value: controller.totalQuickGames,
          ),
          StatsValueWidget(
            text: 'All games',
            value: controller.totalNormalGames + controller.totalQuickGames,
            bigText: true,
          ),

          SizedBox(height: 32.h),

          ///
          /// CORRECT & WRONG ANSWERS
          ///
          const GameTitle(
            'Correct & wrong answers',
            smallTitle: true,
          ),

          SizedBox(height: 12.h),

          StatsValueWidget(
            text: 'Correct answers',
            value: controller.totalCorrectAnswers,
          ),
          StatsValueWidget(
            text: 'Wrong answers',
            value: controller.totalWrongAnswers,
          ),
          StatsValueWidget(
            text: 'All answers',
            value: controller.totalCorrectAnswers + controller.totalWrongAnswers,
            bigText: true,
          ),
        ],
      );
}
