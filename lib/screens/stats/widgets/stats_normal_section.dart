import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../localization.dart';
import '../../../widgets/game_title.dart';
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
                final time = DateFormat('d. MMMM - H:m', Localization.locale?.languageCode ?? 'en').format(normalGame.startTime);

                return StatsValueWidget(
                  text: '${index + 1}. $time',
                  onPressed: () {
                    log(normalGame.toString());
                  },
                );
              },
            ),
        ],
      );
}