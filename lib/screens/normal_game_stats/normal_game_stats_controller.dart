import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';

final normalGameStatsProvider = Provider.autoDispose.family<NormalGameStatsController, NormalGameStats>(
  (ref, normalGameStats) {
    final normalGameStatsController = NormalGameStatsController(
      normalGameStats: normalGameStats,
      logger: ref.watch(loggerProvider),
      path: ref.watch(pathProvider),
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
  final PathProviderService path;

  NormalGameStatsController({
    required this.normalGameStats,
    required this.logger,
    required this.path,
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
  Future<void> toggleAudio(String audioPath) async {
    if (await path.doesFileExist(audioPath)) {
      /// User tapped the already active audio
      if (currentPath == audioPath) {
        unawaited(audioPlayer.playing ? audioPlayer.pause() : audioPlayer.play());
        return;
      }

      /// User tapped new audio, play it
      currentPath = audioPath;
      await audioPlayer.stop();
      await audioPlayer.setFilePath(audioPath, preload: false);
      unawaited(audioPlayer.play());
    }
  }
}
