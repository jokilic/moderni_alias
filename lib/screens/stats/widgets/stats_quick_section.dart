import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/game_title.dart';
import '../stats_controller.dart';
import 'stats_value_widget.dart';

class StatsQuickSection extends GetView<StatsController> {
  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ///
          /// QUICK GAMES
          ///
          const GameTitle('QUICK GAMES'),

          SizedBox(height: 12.h),

          if (controller.quickGameStats.isEmpty)
            const StatsValueWidget(
              text: "you haven't played any quick games yet",
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.quickGameStats.length,
              itemBuilder: (_, index) {
                final quickGame = controller.quickGameStats[index];

                return Container(
                  color: Colors.blueAccent,
                  height: 40,
                  width: 40,
                );
              },
            ),
        ],
      );
}
