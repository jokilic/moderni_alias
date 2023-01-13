// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../localization.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import 'stats_controller.dart';
import 'widgets/stats_segmented_widget.dart';
import 'widgets/stats_value_widget.dart';

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
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    StatsSegmentedWidget(),
                    SizedBox(height: 20.h),

                    ///
                    /// GENERAL
                    ///
                    const GameTitle(
                      'Total games played',
                      smallTitle: true,
                    ),

                    Column(
                      children: [
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
                      ],
                    ),

                    SizedBox(height: 32.h),

                    ///
                    /// CORRECT & WRONG ANSWERS
                    ///
                    const GameTitle(
                      'Correct & wrong answers',
                      smallTitle: true,
                    ),

                    Column(
                      children: [
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
                    ),

                    ///
                    /// NORMAL GAMES
                    ///
                    const GameTitle('NORMAL GAMES'),

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

                    ///
                    /// QUICK GAMES
                    ///
                    const GameTitle('QUICK GAMES'),

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
                ),
              ),
            ),
          ),
        ),
      );
}
