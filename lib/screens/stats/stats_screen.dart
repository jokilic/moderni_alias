import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import 'widgets/stats_table_row_widget.dart';

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
                    const StatsTableRowWidget(
                      text: 'Normal games',
                      value: 3,
                    ),
                    const StatsTableRowWidget(
                      text: 'Quick games',
                      value: 9,
                    ),
                    const StatsTableRowWidget(
                      text: 'All games',
                      value: 12,
                      bigText: true,
                    ),
                    SizedBox(height: 32.h),

                    /// Correct & wrong answers
                    const GameTitle(
                      'Correct & wrong answers',
                      smallTitle: true,
                    ),
                    SizedBox(height: 16.h),
                    const StatsTableRowWidget(
                      text: 'Correct answers',
                      value: 27,
                    ),
                    const StatsTableRowWidget(
                      text: 'Wrong answers',
                      value: 4,
                    ),
                    const StatsTableRowWidget(
                      text: 'All answers',
                      value: 31,
                      bigText: true,
                    ),
                    SizedBox(height: 32.h),

                    /// Average answers per game
                    const GameTitle(
                      'Average answers per game',
                      smallTitle: true,
                    ),
                    SizedBox(height: 16.h),
                    const StatsTableRowWidget(
                      text: 'Correct answers',
                      value: 6,
                    ),
                    const StatsTableRowWidget(
                      text: 'Wrong answers',
                      value: 3,
                    ),
                    const StatsTableRowWidget(
                      text: 'All answers',
                      value: 11,
                      bigText: true,
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
