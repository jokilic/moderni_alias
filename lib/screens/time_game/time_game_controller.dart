import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/enums.dart';
import '../../constants/images.dart';
import '../../models/played_word/played_word.dart';
import '../../models/round/round.dart';
import '../../models/team/team.dart';
import '../../models/time_game_stats/time_game_stats.dart';
import '../../services/audio_record_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';
import '../../util/providers.dart';
import '../../util/routing.dart';
import '../../widgets/background_image.dart';
import '../../widgets/scores/show_time_scores.dart';

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
      numberOfWords: ref.read(wordsToWinProvider),
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
        (timer) => ref.read(timeGameTimerProvider.notifier).state = Duration(
          seconds: timer.tick,
        ),
      );

  /// Changes background depending on the percentage of solved words
  void updateBackground() {
    final percentageOfSolvedWords = 1 - (correctAnswers / ref.read(wordsToWinProvider));

    /// Show green background
    if (percentageOfSolvedWords <= 0.6 && percentageOfSolvedWords > 0.4) {
      ref.read(backgroundImageProvider.notifier).changeBackground(
            ModerniAliasImages.blurred3,
            isTemporary: true,
          );
    }

    /// Show yellow background
    else if (percentageOfSolvedWords <= 0.4 && percentageOfSolvedWords > 0.15) {
      ref.read(backgroundImageProvider.notifier).changeBackground(
            ModerniAliasImages.blurred18,
            isTemporary: true,
          );
    }

    /// Show red background
    else if (percentageOfSolvedWords <= 0.15) {
      ref.read(backgroundImageProvider.notifier).changeBackground(
            ModerniAliasImages.blurred2,
            isTemporary: true,
          );
    }
  }

  /// Counts down the 3 seconds before starting new round
  Future<void> start3SecondCountdown() async {
    ref.read(currentGameProvider.notifier).state = Game.starting;
    ref.read(counter3SecondsProvider.notifier).state = 3;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        ref.read(counter3SecondsProvider.notifier).state -= 1;

        /// Timer is done, start round
        if (ref.read(counter3SecondsProvider) == 0) {
          timer.cancel();
          startRound();
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

    ref.read(dictionaryProvider.notifier).getRandomWord();

    ref.read(currentGameProvider.notifier).state = Game.time;
    ref.read(timeGameTimerProvider.notifier).state = Duration.zero;

    ref.read(backgroundImageProvider.notifier).changeBackground(
          ModerniAliasImages.blurred1,
          isTemporary: true,
        );

    startTimer();
  }

  /// Checks if team has guessed the selected number of words
  void checkRoundDone(BuildContext context) {
    /// User has guessed the proper number of words, round is done
    if (ref.read(currentlyPlayingTeamProvider).points >= ref.read(wordsToWinProvider)) {
      gameStopped();

      final currentTeamIndex = ref.read(teamsProvider).indexOf(
            ref.read(currentlyPlayingTeamProvider),
          );

      if (currentTeamIndex < ref.read(teamsProvider).length - 1) {
        continueGame(
          ref.read(teamsProvider),
          context: context,
        );
      } else {
        endGame(context);
      }
    }
  }

  /// Gets called when the game is on hold (round ended, waiting for new round start)
  void gameStopped() {
    ref.read(currentGameProvider.notifier).state = Game.tapToStart;
    ref.read(backgroundImageProvider.notifier).revertBackground();

    ref.read(timeGameEndPlayerProvider).load();
    ref.read(timeGameEndPlayerProvider).play();
    timer?.cancel();
  }

  /// Continues game with next team
  Future<void> continueGame(List<Team> playingTeams, {required BuildContext context}) async {
    await showScoresSheet(context);

    await updateHiveStats(gameType: Game.tapToStart);

    final currentTeamIndex = ref.read(teamsProvider).indexOf(
          ref.read(currentlyPlayingTeamProvider),
        );
    ref.read(currentlyPlayingTeamProvider.notifier).state = ref.read(teamsProvider)[currentTeamIndex + 1];
  }

  /// Goes to the confetti screen and shows info about the round
  Future<void> endGame(BuildContext context) async {
    ref.read(currentGameProvider.notifier).state = Game.end;
    await ref.read(backgroundImageProvider.notifier).revertBackground();

    await updateHiveStats(gameType: Game.time);
    goToTimeGameFinishedScreen(context);
  }

  ///
  /// ANSWER
  ///

  void answerChosen({required Answer chosenAnswer, required BuildContext context}) {
    /// Game is not running, handle tapping answer
    if (ref.read(currentGameProvider) == Game.tapToStart) {
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

    /// Player chose the `Correct` button
    if (chosenAnswer == Answer.correct) {
      correctAnswers++;
      ref.read(currentlyPlayingTeamProvider)
        ..points += 1
        ..correctPoints += 1;
    }

    /// Player chose the `Wrong` button
    else {
      wrongAnswers++;
      ref.read(currentlyPlayingTeamProvider).wrongPoints += 1;
    }

    /// Update background
    updateBackground();

    /// Add answer to list of `playedWords` (for showing in the end of the round)
    ref.read(playedWordsProvider).add(
          PlayedWord(
            word: ref.read(dictionaryProvider),
            chosenAnswer: chosenAnswer,
          ),
        );

    /// Check if player has guessed the selected number of words
    checkRoundDone(context);

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
    showTimeScores(
      context,
      playedWords: ref.read(playedWordsProvider),
      dismissible: false,
      roundEnd: true,
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
          durationSeconds: timer?.tick,
        ),
      ],
    );

    if (gameType == Game.time) {
      await ref.read(hiveProvider).addTimeGameStatsToBox(timeGameStats: timeGameStats);
    }
  }
}
