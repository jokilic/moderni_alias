import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/game_stats.dart';
import 'logger_service.dart';

class HiveService extends GetxService {
  final logger = Get.find<LoggerService>();

  ///
  /// VARIABLES
  ///

  final newGameStats = GameStats(
    playedQuickGames: 0,
    playedNormalGames: 0,
    correctAnswersQuickGames: 0,
    wrongAnswersQuickGames: 0,
    correctAnswersNormalGames: 0,
    wrongAnswersNormalGames: 0,
    playedNormalGameRounds: 0,
  );

  late final Box<GameStats> _statsBox;
  Box<GameStats> get statsBox => _statsBox;
  set statsBox(Box<GameStats> value) => _statsBox = value;

  ///
  /// INIT
  ///

  @override
  Future<void> onInit() async {
    super.onInit();

    await Hive.initFlutter();
    Hive.registerAdapter(GameStatsAdapter());
    statsBox = await Hive.openBox<GameStats>('gameStatsBox');
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onClose() async {
    await statsBox.close();
    await Hive.close();
    super.onClose();
  }

  ///
  /// METHODS
  ///

  /// Called to add a new stats value to [Hive]
  Future<void> addStatsToBox({required GameStats gameStats}) async => statsBox.put(0, gameStats);

  /// Called to get stats value from [Hive]
  GameStats getStatsFromBox() => statsBox.get(0) ?? newGameStats;
}
