import 'package:get/get.dart';

import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../services/hive_service.dart';

class StatsController extends GetxController {
  final hiveService = Get.find<HiveService>();

  ///
  /// VARIABLES
  ///

  late final List<NormalGameStats> normalGameStats;
  late final List<QuickGameStats> quickGameStats;

  ///
  /// INIT
  ///

  @override
  void onInit() {
    super.onInit();

    normalGameStats = hiveService.getNormalGameStatsFromBox();
    quickGameStats = hiveService.getQuickGameStatsFromBox();
    calculateValues();
  }

  ///
  /// METHODS
  ///

  /// Calculates all values
  void calculateValues() {
    // if (gameStats == Get.find<HiveService>().newGameStats) {
    //   return;
    // }

    // totalNormalGames = gameStats.playedNormalGames;
    // totalQuickGames = gameStats.playedQuickGames;
    // totalRounds = gameStats.playedNormalGameRounds;
    // totalGames = totalNormalGames + totalQuickGames;

    // totalCorrectAnswers = gameStats.correctAnswersNormalGames + gameStats.correctAnswersQuickGames;
    // totalWrongAnswers = gameStats.wrongAnswersNormalGames + gameStats.wrongAnswersQuickGames;
    // totalAnswers = totalCorrectAnswers + totalWrongAnswers;

    // if (totalGames != 0) {
    //   totalAverageCorrectAnswers = totalCorrectAnswers ~/ totalGames;
    //   totalAverageWrongAnswers = totalWrongAnswers ~/ totalGames;
    //   totalAverageAnswers = totalAnswers ~/ totalGames;
    // }

    // if (totalRounds != 0) {
    //   averageCorrectAnswersRounds = gameStats.correctAnswersNormalGames ~/ totalRounds;
    //   averageWrongAnswersRounds = gameStats.wrongAnswersNormalGames ~/ totalRounds;
    // }
  }
}
