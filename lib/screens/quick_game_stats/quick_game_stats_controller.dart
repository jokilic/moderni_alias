// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../services/logger_service.dart';

final quickGameStatsProvider = NotifierProvider.autoDispose<QuickGameStatsController, QuickGameStats?>(
  QuickGameStatsController.new,
  name: 'QuickGameStatsProvider',
);

class QuickGameStatsController extends AutoDisposeNotifier<QuickGameStats?> {
  @override
  QuickGameStats? build() {
    init();
    ref.onDispose(dispose);
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

  /// Updates state with new [QuickGameStats]
  void updateState(QuickGameStats? newState) {
    state = newState;
  }
}
