import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../services/logger_service.dart';

final quickGameStatsProvider = Provider.autoDispose.family<QuickGameStatsController, QuickGameStats>(
  (ref, quickGameStats) {
    final quickGameStatsController = QuickGameStatsController(
      quickGameStats: quickGameStats,
      logger: ref.watch(loggerProvider),
    );
    ref.onDispose(quickGameStatsController.dispose);
    return quickGameStatsController;
  },
  name: 'QuickGameStatsProvider',
);

class QuickGameStatsController {
  ///
  /// CONSTRUCTOR
  ///

  final QuickGameStats quickGameStats;
  final LoggerService logger;

  QuickGameStatsController({
    required this.quickGameStats,
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final audioPlayer = AudioPlayer();
  String? currentPath;

  ///
  /// DISPOSE
  ///

  Future<void> dispose() async {
    await audioPlayer.dispose();
  }

  ///
  /// METHODS
  ///

  /// Plays / pauses audio file
  Future<void> toggleAudio(String path) async {
    /// User tapped the already active audio
    if (currentPath == path) {
      unawaited(audioPlayer.playing ? audioPlayer.pause() : audioPlayer.play());
      return;
    }

    /// User tapped new audio, play it
    currentPath = path;
    await audioPlayer.stop();
    await audioPlayer.setFilePath(path, preload: false);
    unawaited(audioPlayer.play());
  }
}
