// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';

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

  var totalNormalGames = 0;
  var totalQuickGames = 0;
  var totalGames = 0;

  late PageController pageController;

  var totalCorrectAnswersNormalGames = 0;
  var totalCorrectAnswersQuickGames = 0;
  var totalWrongAnswersNormalGames = 0;
  var totalWrongAnswersQuickGames = 0;
  var totalRounds = 0;

  var totalAverageCorrectAnswers = 0;
  var totalAverageWrongAnswers = 0;
  var totalAverageAnswers = 0;

  var averageCorrectAnswersRounds = 0;
  var averageWrongAnswersRounds = 0;
  var averageAnswersRounds = 0;

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
    totalGames = totalNormalGames + totalQuickGames;

    /// Calculate total correct and wrong answers in all normal games
    for (final normalGame in normalGameStats) {
      for (final round in normalGame.rounds) {
        totalRounds = totalRounds + 1;

        for (final word in round.playedWords) {
          word.chosenAnswer == Answer.correct ? totalCorrectAnswersNormalGames += 1 : totalWrongAnswersNormalGames += 1;
        }
      }
    }

    /// Calculate total correct and wrong answers in all quick games
    for (final quickGame in quickGameStats) {
      for (final playedWord in quickGame.round.playedWords) {
        playedWord.chosenAnswer == Answer.correct ? totalCorrectAnswersQuickGames += 1 : totalWrongAnswersQuickGames += 1;
      }
    }

    if (totalGames != 0) {
      /// Calculate average answers per game
      totalAverageCorrectAnswers = (totalCorrectAnswersNormalGames + totalCorrectAnswersQuickGames) ~/ totalGames;
      totalAverageWrongAnswers = (totalWrongAnswersNormalGames + totalWrongAnswersQuickGames) ~/ totalGames;
      totalAverageAnswers = ((totalCorrectAnswersNormalGames + totalCorrectAnswersQuickGames) + (totalWrongAnswersNormalGames + totalWrongAnswersQuickGames)) ~/ totalGames;
    }

    if (totalRounds != 0) {
      /// Calculate average answers per round
      averageCorrectAnswersRounds = totalCorrectAnswersNormalGames ~/ totalRounds;
      averageWrongAnswersRounds = totalWrongAnswersNormalGames ~/ totalRounds;
      averageAnswersRounds = (totalCorrectAnswersNormalGames + totalWrongAnswersNormalGames) ~/ totalRounds;
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
