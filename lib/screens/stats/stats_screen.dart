import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';

class StatsScreen extends StatelessWidget {
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
                    SizedBox(height: 50.h),
                    const HeroTitle(),
                    SizedBox(height: 40.h),

                    /// Total games played
                    const GameTitle(
                      'Total games played',
                      smallTitle: true,
                    ),
                    SizedBox(height: 16.h),
                    // StatsTableRowWidget(
                    //   text: 'Normal games',
                    //   value: statsController.totalNormalGames,
                    // ),
                    // StatsTableRowWidget(
                    //   text: 'Quick games',
                    //   value: statsController.totalQuickGames,
                    // ),
                    // StatsTableRowWidget(
                    //   text: 'All games',
                    //   value: statsController.totalGames,
                    //   bigText: true,
                    // ),
                    SizedBox(height: 32.h),

                    /// Correct & wrong answers
                    const GameTitle(
                      'Correct & wrong answers',
                      smallTitle: true,
                    ),
                    SizedBox(height: 16.h),
                    // StatsTableRowWidget(
                    //   text: 'Correct answers',
                    //   value: statsController.totalCorrectAnswers,
                    // ),
                    // StatsTableRowWidget(
                    //   text: 'Wrong answers',
                    //   value: statsController.totalWrongAnswers,
                    // ),
                    // StatsTableRowWidget(
                    //   text: 'All answers',
                    //   value: statsController.totalAnswers,
                    //   bigText: true,
                    // ),
                    SizedBox(height: 32.h),

                    /// Average answers per game
                    const GameTitle(
                      'Average answers per game',
                      smallTitle: true,
                    ),
                    SizedBox(height: 16.h),
                    // StatsTableRowWidget(
                    //   text: 'Correct answers',
                    //   value: statsController.totalAverageCorrectAnswers,
                    // ),
                    // StatsTableRowWidget(
                    //   text: 'Wrong answers',
                    //   value: statsController.totalAverageWrongAnswers,
                    // ),
                    // StatsTableRowWidget(
                    //   text: 'All answers',
                    //   value: statsController.totalAverageAnswers,
                    //   bigText: true,
                    // ),
                    SizedBox(height: 32.h),

                    /// Average answers per round
                    const GameTitle(
                      'Average answers per round',
                      smallTitle: true,
                    ),
                    SizedBox(height: 16.h),
                    // StatsTableRowWidget(
                    //   text: 'Correct answers',
                    //   value: statsController.averageCorrectAnswersRounds,
                    // ),
                    // StatsTableRowWidget(
                    //   text: 'Wrong answers',
                    //   value: statsController.averageWrongAnswersRounds,
                    // ),
                    // StatsTableRowWidget(
                    //   text: 'Rounds',
                    //   value: statsController.totalRounds,
                    //   bigText: true,
                    // ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
