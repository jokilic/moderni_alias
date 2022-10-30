import 'package:get/get.dart';

import '../../models/game_stats.dart';
import '../../services/hive_service.dart';

class StatsController extends GetxController {
  ///
  /// VARIABLES
  ///

  late final GameStats gameStats;

  /// Games
  final _totalNormalGames = 0.obs;
  final _totalQuickGames = 0.obs;
  final _totalGames = 0.obs;

  /// Answers
  final _totalCorrectAnswers = 0.obs;
  final _totalWrongAnswers = 0.obs;
  final _totalAnswers = 0.obs;

  /// Average
  final _totalAverageCorrectAnswers = 0.obs;
  final _totalAverageWrongAnswers = 0.obs;
  final _totalAverageAnswers = 0.obs;

  /// Rounds
  final _totalRounds = 0.obs;
  final _averageCorrectAnswersRounds = 0.obs;
  final _averageWrongAnswersRounds = 0.obs;

  ///
  /// GETTERS
  ///

  int get totalNormalGames => _totalNormalGames.value;
  int get totalQuickGames => _totalQuickGames.value;
  int get totalGames => _totalGames.value;
  int get totalCorrectAnswers => _totalCorrectAnswers.value;
  int get totalWrongAnswers => _totalWrongAnswers.value;
  int get totalAnswers => _totalAnswers.value;
  int get totalAverageCorrectAnswers => _totalAverageCorrectAnswers.value;
  int get totalAverageWrongAnswers => _totalAverageWrongAnswers.value;
  int get totalAverageAnswers => _totalAverageAnswers.value;
  int get totalRounds => _totalRounds.value;
  int get averageCorrectAnswersRounds => _averageCorrectAnswersRounds.value;
  int get averageWrongAnswersRounds => _averageWrongAnswersRounds.value;

  ///
  /// SETTERS
  ///

  set totalNormalGames(int value) => _totalNormalGames.value = value;
  set totalQuickGames(int value) => _totalQuickGames.value = value;
  set totalGames(int value) => _totalGames.value = value;
  set totalCorrectAnswers(int value) => _totalCorrectAnswers.value = value;
  set totalWrongAnswers(int value) => _totalWrongAnswers.value = value;
  set totalAnswers(int value) => _totalAnswers.value = value;
  set totalAverageCorrectAnswers(int value) => _totalAverageCorrectAnswers.value = value;
  set totalAverageWrongAnswers(int value) => _totalAverageWrongAnswers.value = value;
  set totalAverageAnswers(int value) => _totalAverageAnswers.value = value;
  set totalRounds(int value) => _totalRounds.value = value;
  set averageCorrectAnswersRounds(int value) => _averageCorrectAnswersRounds.value = value;
  set averageWrongAnswersRounds(int value) => _averageWrongAnswersRounds.value = value;

  ///
  /// INIT
  ///

  @override
  void onInit() {
    super.onInit();
    gameStats = Get.find<HiveService>().getStatsFromBox();
    calculateValues();
  }

  ///
  /// METHODS
  ///

  /// Calculates all values
  void calculateValues() {
    if (gameStats == Get.find<HiveService>().newGameStats) {
      return;
    }

    totalNormalGames = gameStats.playedNormalGames;
    totalQuickGames = gameStats.playedQuickGames;
    totalRounds = gameStats.playedNormalGameRounds;
    totalGames = totalNormalGames + totalQuickGames;

    totalCorrectAnswers = gameStats.correctAnswersNormalGames + gameStats.correctAnswersQuickGames;
    totalWrongAnswers = gameStats.wrongAnswersNormalGames + gameStats.wrongAnswersQuickGames;
    totalAnswers = totalCorrectAnswers + totalWrongAnswers;

    if (totalGames != 0) {
      totalAverageCorrectAnswers = totalCorrectAnswers ~/ totalGames;
      totalAverageWrongAnswers = totalWrongAnswers ~/ totalGames;
      totalAverageAnswers = totalAnswers ~/ totalGames;
    }

    if (totalRounds != 0) {
      averageCorrectAnswersRounds = gameStats.correctAnswersNormalGames ~/ totalRounds;
      averageWrongAnswersRounds = gameStats.wrongAnswersNormalGames ~/ totalRounds;
    }
  }
}
