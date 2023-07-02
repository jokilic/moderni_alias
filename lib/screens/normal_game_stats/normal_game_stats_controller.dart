import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../services/logger_service.dart';

final normalGameStatsProvider = Provider.autoDispose.family<NormalGameStatsController, NormalGameStats>(
  (ref, normalGameStats) {
    final normalGameStatsController = NormalGameStatsController(
      normalGameStats: normalGameStats,
      logger: ref.watch(loggerProvider),
    );
    ref.onDispose(normalGameStatsController.dispose);
    return normalGameStatsController;
  },
  name: 'NormalGameStatsProvider',
);

class NormalGameStatsController {
  ///
  /// CONSTRUCTOR
  ///

  final NormalGameStats normalGameStats;
  final LoggerService logger;

  NormalGameStatsController({
    required this.normalGameStats,
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

  void dispose() {
    audioPlayer.dispose();
  }

  ///
  /// METHODS
  ///

  /// Plays / pauses audio file
  Future<void> toggleAudio(String path) async {
    /// User tapped the already active audio
    if (currentPath == path) {
      if (audioPlayer.playing) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.play();
      }
      return;
    }

    /// User tapped new audio, play it
    currentPath = path;
    await audioPlayer.stop();
    await audioPlayer.setFilePath(path, preload: false);
    unawaited(audioPlayer.play());
  }
}
