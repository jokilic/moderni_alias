// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart';

import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../models/time_game_stats/time_game_stats.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';

class StatsController extends ValueNotifier<int?> implements Disposable {
  final LoggerService logger;
  final HiveService hive;

  StatsController({
    required this.logger,
    required this.hive,
  }) : super(null);

  ///
  /// VARIABLES
  ///

  late List<NormalGameStats> normalGameStats;
  late List<QuickGameStats> quickGameStats;
  late List<TimeGameStats> timeGameStats;

  var totalNormalGames = 0;
  var totalTimeGames = 0;
  var totalQuickGames = 0;
  var totalGames = 0;

  late PageController pageController;

  var totalCorrectAnswersNormalGames = 0;
  var totalCorrectAnswersTimeGames = 0;
  var totalCorrectAnswersQuickGames = 0;

  var totalWrongAnswersNormalGames = 0;
  var totalWrongAnswersTimeGames = 0;
  var totalWrongAnswersQuickGames = 0;
  var totalRounds = 0;

  var totalAverageCorrectAnswers = 0;
  var totalAverageWrongAnswers = 0;
  var totalAverageAnswers = 0;

  NormalGameStats? activeNormalGameStats;
  TimeGameStats? activeTimeGameStats;
  QuickGameStats? activeQuickGameStats;

  ///
  /// INIT
  ///

  void init() {
    pageController = PageController();

    /// Date formatting
    initializeDateFormatting('en');
    initializeDateFormatting('hr');

    /// [Timeago] formatting
    setLocaleMessages('en', EnMessages());
    setLocaleMessages('hr', HrMessages());

    /// Get values from [Hive]
    normalGameStats = hive.getNormalGameStatsFromBox();
    quickGameStats = hive.getQuickGameStatsFromBox();
    timeGameStats = hive.getTimeGameStatsFromBox();

    /// Calculate stats
    calculateValues();
  }

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    pageController.dispose();
  }

  ///
  /// METHODS
  ///

  /// Calculates all values
  void calculateValues() {
    /// Calculate total games
    totalNormalGames = normalGameStats.length;
    totalQuickGames = quickGameStats.length;
    totalTimeGames = timeGameStats.length;
    totalGames = totalNormalGames + totalQuickGames + totalTimeGames;

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

    /// Calculate total correct and wrong answers in all time games
    for (final timeGame in timeGameStats) {
      for (final round in timeGame.rounds) {
        totalRounds = totalRounds + 1;

        for (final word in round.playedWords) {
          word.chosenAnswer == Answer.correct ? totalCorrectAnswersTimeGames += 1 : totalWrongAnswersTimeGames += 1;
        }
      }
    }

    /// Calculate average answers per game
    if (totalGames != 0) {
      totalAverageCorrectAnswers = (totalCorrectAnswersNormalGames + totalCorrectAnswersQuickGames + totalCorrectAnswersTimeGames) ~/ totalGames;
      totalAverageWrongAnswers = (totalWrongAnswersNormalGames + totalWrongAnswersQuickGames + totalWrongAnswersTimeGames) ~/ totalGames;
      totalAverageAnswers = ((totalCorrectAnswersNormalGames + totalCorrectAnswersQuickGames + totalCorrectAnswersTimeGames) +
              (totalWrongAnswersNormalGames + totalWrongAnswersQuickGames + totalWrongAnswersTimeGames)) ~/
          totalGames;
    }
  }

  /// Triggered when the user taps some [StatsSegmentedValueWidget]
  void segmentedValuePressed(int newIndex) {
    if (value == newIndex) {
      value = null;
    } else {
      value = newIndex;

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => pageController.animateToPage(
          value ?? 4,
          duration: ModerniAliasDurations.animation,
          curve: Curves.easeIn,
        ),
      );
    }
  }

  /// Triggered when [PageView] page is changed (swiping)
  void pageChanged(int newIndex) {
    value = newIndex;
  }
}
