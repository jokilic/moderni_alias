import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/icons.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';
import 'stats_controller.dart';
import 'widgets/stats_general_section.dart';
import 'widgets/stats_normal_section.dart';
import 'widgets/stats_quick_section.dart';
import 'widgets/stats_segmented_widget.dart';
import 'widgets/stats_time_section.dart';

class StatsScreen extends WatchingStatefulWidget {
  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<StatsController>(
      () => StatsController(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
      ),
      afterRegister: (controller) => controller.init(),
    );
  }

  @override
  void dispose() {
    unregisterIfInitialized<StatsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = watchIt<StatsController>().value;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AnimatedGestureDetector(
                      onTap: Navigator.of(context).pop,
                      end: 0.8,
                      child: IconButton(
                        onPressed: null,
                        icon: Transform.rotate(
                          angle: pi,
                          child: Image.asset(
                            ModerniAliasIcons.arrowStatsImage,
                            color: ModerniAliasColors.white,
                            height: 26,
                            width: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  HeroTitle(smallText: 'statsTitle'.tr()),
                  const SizedBox(height: 40),
                  StatsSegmentedWidget(
                    currentIndex: currentIndex,
                    segmentedValuePressed: getIt.get<StatsController>().segmentedValuePressed,
                  ),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: ModerniAliasDurations.animation,
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeIn,
                    child: switch (currentIndex) {
                      0 => StatsNormalSection(
                        normalGameStats: getIt.get<StatsController>().normalGameStats,
                      ),
                      1 => StatsTimeSection(
                        timeGameStats: getIt.get<StatsController>().timeGameStats,
                      ),
                      2 => StatsQuickSection(
                        quickGameStats: getIt.get<StatsController>().quickGameStats,
                      ),
                      _ => StatsGeneralSection(
                        totalNormalGames: getIt.get<StatsController>().totalNormalGames,
                        totalTimeGames: getIt.get<StatsController>().totalTimeGames,
                        totalQuickGames: getIt.get<StatsController>().totalQuickGames,
                        totalCorrectAnswersNormalGames: getIt.get<StatsController>().totalCorrectAnswersNormalGames,
                        totalCorrectAnswersTimeGames: getIt.get<StatsController>().totalCorrectAnswersTimeGames,
                        totalCorrectAnswersQuickGames: getIt.get<StatsController>().totalCorrectAnswersQuickGames,
                        totalWrongAnswersNormalGames: getIt.get<StatsController>().totalWrongAnswersNormalGames,
                        totalWrongAnswersTimeGames: getIt.get<StatsController>().totalWrongAnswersTimeGames,
                        totalWrongAnswersQuickGames: getIt.get<StatsController>().totalWrongAnswersQuickGames,
                        totalAverageCorrectAnswers: getIt.get<StatsController>().totalAverageCorrectAnswers,
                        totalAverageWrongAnswers: getIt.get<StatsController>().totalAverageWrongAnswers,
                        totalAverageAnswers: getIt.get<StatsController>().totalAverageAnswers,
                      ),
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
