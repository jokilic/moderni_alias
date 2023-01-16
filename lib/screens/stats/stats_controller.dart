import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../constants/enums.dart';
import '../../constants/strings.dart';
import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';

class StatsController extends GetxController {
  final logger = Get.find<LoggerService>();
  final hiveService = Get.find<HiveService>();

  ///
  /// REACTIVE VARIABLES
  ///

  final _currentIndex = Rxn<int?>();
  int? get currentIndex => _currentIndex.value;
  set currentIndex(int? value) => _currentIndex.value = value;

  ///
  /// VARIABLES
  ///

  late List<NormalGameStats> normalGameStats;
  late List<QuickGameStats> quickGameStats;

  late int totalNormalGames;
  late int totalQuickGames;

  late PageController pageController;

  var totalCorrectAnswers = 0;
  var totalWrongAnswers = 0;

  ///
  /// INIT
  ///

  @override
  void onInit() {
    super.onInit();

    pageController = PageController();

    initializeDateFormatting('en');
    initializeDateFormatting('hr');

    normalGameStats = hiveService.getNormalGameStatsFromBox();
    quickGameStats = hiveService.getQuickGameStatsFromBox();

    calculateValues();
  }

  ///
  /// METHODS
  ///

  /// Calculates all values
  void calculateValues() {
    /// Calculate total games
    totalNormalGames = normalGameStats.length;
    totalQuickGames = quickGameStats.length;

    /// Calculate total correct and wrong answers in all normal games
    for (final normalGame in normalGameStats) {
      for (final round in normalGame.rounds) {
        for (final word in round.playedWords) {
          word.chosenAnswer == Answer.correct ? totalCorrectAnswers = totalCorrectAnswers + 1 : totalWrongAnswers = totalWrongAnswers + 1;
        }
      }
    }

    /// Calculate total correct and wrong answers in all quick games
    for (final quickGame in quickGameStats) {
      for (final playedWord in quickGame.round.playedWords) {
        playedWord.chosenAnswer == Answer.correct ? totalCorrectAnswers += 1 : totalWrongAnswers += 1;
      }
    }
  }

  /// Triggered when the user taps some [StatsSegmentedValueWidget]
  void segmentedValuePressed(int newIndex) {
    if (currentIndex == newIndex) {
      currentIndex = null;
    } else {
      currentIndex = newIndex;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => pageController.animateToPage(
          currentIndex ?? 4,
          duration: ModerniAliasDurations.animation,
          curve: Curves.easeIn,
        ),
      );
    }
  }

  /// Triggered when [PageView] page is changed (swiping)
  void pageChanged(int newIndex) {
    currentIndex = newIndex;
  }
}
