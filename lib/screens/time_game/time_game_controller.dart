import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/enums.dart';
import '../../models/played_word/played_word.dart';
import '../../models/round/round.dart';
import '../../models/time_game_stats/time_game_stats.dart';
import '../../services/audio_record_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';
import '../../util/providers.dart';
import '../../util/routing.dart';
import '../normal_game/widgets/show_scores.dart';

final timeGameProvider = Provider.autoDispose<TimeGameController>(
  (ref) {
    final timeGameController = TimeGameController(ref);
    ref.onDispose(timeGameController.dispose);
    return timeGameController;
  },
  name: 'TimeGameProvider',
);

class TimeGameController {
  final ProviderRef ref;

  TimeGameController(this.ref) {
    init();
  }

  ///
  /// VARIABLES
  ///

  var correctAnswers = 0;
  var wrongAnswers = 0;

  Timer? timer;

  late TimeGameStats timeGameStats;

  ///
  /// INIT
  ///

  void init() {
    timeGameStats = TimeGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      teams: List.from(ref.read(teamsProvider)),
      rounds: [],
      language: ref.read(chosenDictionaryProvider),
    );
  }

  ///
  /// DISPOSE
  ///

  void dispose() {
    timer?.cancel();
  }

  ///
  /// TIMER & COUNTDOWN
  ///

  /// Sets the variables and starts the Timer
  void startTimer() => timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => ref.read(loggerProvider).wtf('TIME: ${timer.tick}'),
      );

  /// Counts down the 3 seconds before starting new round
  Future<void> start3SecondCountdown() async {
    ref.read(currentGameProvider.notifier).state = Game.starting;
    ref.read(counter3SecondsProvider.notifier).state = 3;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        ref.read(counter3SecondsProvider.notifier).state -= 1;

        if (ref.read(counter3SecondsProvider) == 0) {
          timer.cancel();
        }
      },
    );

    await startAudioRecording();
  }

  ///
  /// ROUNDS
  ///

  /// Reset variables and start the round
  void startRound() {
    correctAnswers = 0;
    wrongAnswers = 0;
    ref.read(playedWordsProvider).clear();

    ref.read(currentGameProvider.notifier).state = Game.time;
    ref.read(dictionaryProvider.notifier).getRandomWord();

    startTimer();
  }

  /// Gets called when the game is on hold (round ended, waiting for new round start)
  void gameStopped() {
    ref.read(currentGameProvider.notifier).state = Game.none;
    timer?.cancel();
  }

  /// Continues game with next team
  Future<void> continueGame({required BuildContext context}) async {
    gameStopped();

    await showScoresSheet(context);

    await updateHiveStats(gameType: Game.none);

    final currentTeamIndex = ref.read(teamsProvider).indexOf(
          ref.read(currentlyPlayingTeamProvider),
        );

    if (currentTeamIndex < ref.read(teamsProvider).length - 1) {
      ref.read(currentlyPlayingTeamProvider.notifier).state = ref.read(teamsProvider)[currentTeamIndex + 1];
    } else {
      endGame(context);
    }
  }

  /// Goes to the confetti screen and shows info about the round
  void endGame(BuildContext context) {
    updateHiveStats(gameType: Game.time);
    goToTimeGameFinishedScreen(context);
  }

  ///
  /// ANSWER
  ///

  void answerChosen({required Answer chosenAnswer}) {
    /// Game is not running, handle tapping answer
    if (ref.read(currentGameProvider) == Game.none) {
      start3SecondCountdown();
      return;
    }

    /// Game is starting, don't do anything
    if (ref.read(currentGameProvider) == Game.starting) {
      return;
    }

    /// Game is running
    /// 1. Play proper sound
    /// 2. Add an answer to the variable
    /// 3. Add answer to list of `playedWords` (for showing in the end of the round)
    /// 4. Get another random word

    /// Play proper sound
    playAnswerSound(chosenAnswer: chosenAnswer);

    /// Add answer to list of `playedWords` (for showing in the end of the round)
    ref.read(playedWordsProvider).add(
          PlayedWord(
            word: ref.read(dictionaryProvider),
            chosenAnswer: chosenAnswer,
          ),
        );

    /// Get another random word
    ref.read(dictionaryProvider.notifier).getRandomWord();
  }

  /// Plays proper sound while pressing on the answers
  void playAnswerSound({required Answer chosenAnswer}) {
    if (chosenAnswer == Answer.correct) {
      ref.read(correctPlayerProvider).load();
      ref.read(correctPlayerProvider).play();
    } else {
      ref.read(wrongPlayerProvider).load();
      ref.read(wrongPlayerProvider).play();
    }
  }

  ///
  /// SCORES SHEET
  ///

  /// Shows scores sheet and dismisses it after some time
  Future<void> showScoresSheet(BuildContext context) async {
    showScores(
      teams: ref.read(teamsProvider),
      playedWords: ref.read(playedWordsProvider),
      dismissible: false,
      context: context,
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pop();
  }

  ///
  /// RECORD
  ///

  /// Generates proper `path` and starts audio recording
  Future<void> startAudioRecording() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '${ref.read(pathProvider).appDocDirectory}/$timestamp';
    await ref.read(audioRecordProvider).startRecording(path);
  }

  /// Stores the audio file to application directory
  Future<String?> saveAudioFile() async {
    try {
      return await ref.read(audioRecordProvider).stopRecording();
    } catch (e) {
      ref.read(loggerProvider).e('Error in saveAudioFile()\n$e');
    }
    return null;
  }

  ///
  /// HIVE
  ///

  /// Save audio file and update stats and store them in [Hive]
  Future<void> updateHiveStats({required Game gameType}) async {
    timeGameStats = timeGameStats.copyWith(
      endTime: gameType == Game.time ? DateTime.now() : null,
      rounds: [
        ...timeGameStats.rounds,
        Round(
          playedWords: List.from(ref.read(playedWordsProvider)),
          playingTeam: ref.read(currentlyPlayingTeamProvider),
          audioRecording: await saveAudioFile(),
          time: DateTime.now(),
        ),
      ],
    );

    if (gameType == Game.time) {
      await ref.read(hiveProvider).addTimeGameStatsToBox(timeGameStats: timeGameStats);
    }
  }
}
