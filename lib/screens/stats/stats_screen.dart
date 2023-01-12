import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';
import 'stats_controller.dart';
import 'widgets/stats_animated_list.dart';
import 'widgets/stats_table_row_widget.dart';
import 'widgets/stats_title_button.dart';

class StatsScreen extends GetView<StatsController> {
  static const routeName = '/stats-screen';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(
                  () => AnimatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.h),
                      const HeroTitle(),
                      SizedBox(height: 40.h),

                      ///
                      /// TOTAL GAMES PLAYED
                      ///
                      StatsTitleButton(
                        text: 'Total games played',
                        onPressed: () => controller.titleButtonPressed(
                          pressedActiveStats: ActiveStats.totalGames,
                        ),
                        activeIcon: controller.activeStats == ActiveStats.totalGames,
                      ),

                      StatsAnimatedList(
                        widgets: [
                          StatsTableRowWidget(
                            text: 'Normal games',
                            value: controller.totalNormalGames,
                          ),
                          StatsTableRowWidget(
                            text: 'Quick games',
                            value: controller.totalQuickGames,
                          ),
                          StatsTableRowWidget(
                            text: 'All games',
                            value: controller.totalNormalGames + controller.totalQuickGames,
                            bigText: true,
                          ),
                        ],
                        isOpen: controller.activeStats == ActiveStats.totalGames,
                      ),

                      ///
                      /// CORRECT & WRONG ANSWERS
                      ///
                      StatsTitleButton(
                        text: 'Correct & wrong answers',
                        onPressed: () => controller.titleButtonPressed(
                          pressedActiveStats: ActiveStats.answers,
                        ),
                        activeIcon: controller.activeStats == ActiveStats.answers,
                      ),

                      StatsAnimatedList(
                        widgets: [
                          StatsTableRowWidget(
                            text: 'Correct answers',
                            value: controller.totalCorrectAnswers,
                          ),
                          StatsTableRowWidget(
                            text: 'Wrong answers',
                            value: controller.totalWrongAnswers,
                          ),
                          StatsTableRowWidget(
                            text: 'All answers',
                            value: controller.totalCorrectAnswers + controller.totalWrongAnswers,
                            bigText: true,
                          ),
                        ],
                        isOpen: controller.activeStats == ActiveStats.answers,
                      ),

                      Divider(
                        color: ModerniAliasColors.whiteColor,
                        thickness: 2.r,
                        indent: 24.w,
                        endIndent: 24.w,
                        height: 56.h,
                      ),

                      ///
                      /// NORMAL GAMES
                      ///
                      StatsTitleButton(
                        text: 'NORMAL GAMES',
                        onPressed: () => controller.titleButtonPressed(
                          pressedActiveStats: ActiveStats.normalGames,
                        ),
                        activeIcon: controller.activeStats == ActiveStats.normalGames,
                      ),

                      StatsAnimatedList(
                        isListView: true,
                        listView: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.normalGameStats.length + 2,
                          itemBuilder: (_, index) {
                            final normalGame = controller.normalGameStats[index];

                            return Container(
                              color: Colors.redAccent,
                              height: 40,
                              width: 40,
                            );
                          },
                        ),
                        isOpen: controller.activeStats == ActiveStats.normalGames,
                      ),

                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
