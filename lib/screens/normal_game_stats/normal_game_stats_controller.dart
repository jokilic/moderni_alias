// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../services/logger_service.dart';

final normalGameStatsProvider = NotifierProvider.autoDispose<NormalGameStatsController, NormalGameStats?>(
  NormalGameStatsController.new,
  name: 'NormalGameStatsProvider',
);

class NormalGameStatsController extends AutoDisposeNotifier<NormalGameStats?> {
  @override
  NormalGameStats? build() {
    init();
    return null;
  }

  ///
  /// VARIABLES
  ///

  late final LoggerService logger;
  late final AudioPlayer audioPlayer;

  ///
  /// INIT
  ///

  void init() {
    logger = ref.watch(loggerProvider);
    audioPlayer = AudioPlayer();
  }

  ///
  /// METHODS
  ///

  /// Updates state with a new [NormalGameStats]
  void updateNormalGameStats(NormalGameStats? normalGameStats) {
    state = normalGameStats;
  }

  /// Plays / pauses audio file
  Future<void> toggleAudio(String path) async {
    /// Pause audio file
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    }

    /// Play audio file
    else {
      await audioPlayer.setFilePath(path, preload: false);
      unawaited(audioPlayer.play());
    }
  }
}
