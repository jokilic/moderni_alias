import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../models/arguments/normal_game_arguments.dart';
import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/played_word/played_word.dart';
import '../../models/round/round.dart';
import '../../models/team/team.dart';
import '../../providers.dart';
import '../../routing.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../start_game/start_game_controller.dart';
import 'widgets/show_scores.dart';

final currentlyPlayingTeamProvider = StateProvider.autoDispose<Team>(
  (_) => Team(name: ''),
  name: 'CurrentlyPlayingTeamProvider',
);
final tieBreakTeamsProvider = StateProvider.autoDispose<List<Team>?>(
  (_) => null,
  name: 'TieBreakTeamsProvider',
);

final normalGameProvider = Provider.autoDispose.family<NormalGameController, NormalGameArguments>(
  (ref, arguments) {
    final normalGameController = NormalGameController(
      ref,
      arguments: arguments,
    );
    ref.onDispose(normalGameController.dispose);
    return normalGameController;
  },
  name: 'NormalGameProvider',
);

class NormalGameController {
  final ProviderRef ref;
  final NormalGameArguments arguments;

  NormalGameController(
    this.ref, {
    required this.arguments,
  }) {
    init();
  }

  ///
  /// VARIABLES
  ///

  var correctAnswers = 0;
  var wrongAnswers = 0;

  var greenSeconds = 0.0;
  var yellowSeconds = 0.0;
  var redSeconds = 0.0;

  Timer? greenTimer;
  Timer? yellowTimer;
  Timer? redTimer;
  Timer? soundTimer;

  late NormalGameStats normalGameStats;

  ///
  /// INIT
  ///

  void init() {
    normalGameStats = NormalGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      teams: List.from(arguments.teams),
      rounds: [],
      lengthOfRound: arguments.lengthOfRound,
      pointsToWin: arguments.pointsToWin,
      language: arguments.chosenDictionary,
    );
  }

  ///
  /// DISPOSE
  ///

  void dispose() {
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();
    soundTimer?.cancel();
  }

  ///
  /// TIMERS & COUNTDOWN
  ///

  /// Returns a Timer with the specified length and color
  Timer makeTimer({required double chosenSeconds, required Color chosenColor}) => Timer(
        Duration(seconds: arguments.lengthOfRound - chosenSeconds.round()),
        () => ref.read(countdownTimerFillColorProvider.notifier).state = chosenColor,
      );

  /// Sets the variables and starts the time countdown
  void startTimer() {
    /// Set the time when the colors in the circular timer change
    greenSeconds = arguments.lengthOfRound * 0.6;
    yellowSeconds = arguments.lengthOfRound * 0.4;
    redSeconds = arguments.lengthOfRound * 0.15;

    /// Initialize timer that runs when the round is about to end
    soundTimer = Timer(
      Duration(seconds: arguments.lengthOfRound - 5),
      () {
        ref.read(countdownPlayerProvider).load();
        ref.read(countdownPlayerProvider).play();
      },
    );

    /// Initialize timers that change colors
    greenTimer = makeTimer(
      chosenSeconds: greenSeconds,
      chosenColor: ModerniAliasColors.greenColor,
    );
    yellowTimer = makeTimer(
      chosenSeconds: yellowSeconds,
      chosenColor: ModerniAliasColors.yellowColor,
    );
    redTimer = makeTimer(
      chosenSeconds: redSeconds,
      chosenColor: ModerniAliasColors.redColor,
    );
  }

  /// Counts down the 3 seconds before starting new round
  void start3SecondCountdown() {
    ref.read(currentGameProvider.notifier).state = Game.starting;
    ref.read(counter3SecondsProvider.notifier).state = 3;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        ref.read(counter3SecondsProvider.notifier).state -= 1;

        if (ref.read(counter3SecondsProvider.notifier).state == 0) {
          timer.cancel();
        }
      },
    );
  }

  ///
  /// ROUNDS
  ///

  /// Reset variables and start the round
  void startRound({required Game chosenGame}) {
    correctAnswers = 0;
    wrongAnswers = 0;
    ref.read(playedWordsProvider.notifier).state.clear();

    ref.read(currentGameProvider.notifier).state = chosenGame;
    ref.read(countdownTimerFillColorProvider.notifier).state = ModerniAliasColors.blueColor;

    ref.read(dictionaryProvider.notifier).getRandomWord();

    startTimer();
  }

  /// Gets called when the game is on hold (round ended, waiting for new round start)
  void gameStopped() {
    ref.read(currentGameProvider.notifier).state = Game.none;
    ref.read(countdownTimerFillColorProvider.notifier).state = Colors.transparent;

    soundTimer?.cancel();
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();
  }

  /// Check if there's a winner
  /// If no winner, continue the game with the next team
  /// If winner, show the confetti screen
  void stopGameCheckWinner(BuildContext context) {
    gameStopped();

    /// Check if there are teams which have enough points to win the game
    final teamsWithEnoughPoints = getTeamsWithEnoughPoints();

    /// There are no teams with enough points, continue playing the game
    if (teamsWithEnoughPoints.isEmpty) {
      continueGame(
        ref.read(teamsProvider.notifier).state,
        context: context,
      );
      return;
    }

    ///
    /// There are teams which have enough points to win the game
    ///

    /// Round is not finished, continue playing the game
    final activeTeams = ref.read(tieBreakTeamsProvider.notifier).state ?? ref.read(teamsProvider.notifier).state;
    if (roundNotDone(activeTeams)) {
      continueGame(activeTeams, context: context);
    }

    /// Round is finished, play tie break if there are tied teams or end game
    else {
      handleTieBreak(
        getTiedTeams(teamsWithEnoughPoints),
        context: context,
      );
    }
  }

  /// Returns a list of `Teams` who have enough points to win the game
  List<Team> getTeamsWithEnoughPoints() => ref.read(teamsProvider.notifier).state.where((team) => team.points >= arguments.pointsToWin).toList();

  // Find all teams that are tied for first place
  List<Team> getTiedTeams(List<Team> teamsWithEnoughPoints) {
    final maxPoints = teamsWithEnoughPoints.map((team) => team.points).reduce(max);
    return teamsWithEnoughPoints.where((team) => team.points == maxPoints).toList();
  }

  /// Checks if current round is finished
  bool roundNotDone(List<Team> teamsToCheck) {
    final currentTeamIndex = teamsToCheck.indexOf(ref.read(currentlyPlayingTeamProvider.notifier).state);

    /// Find the maximum points among the teams with enough points
    final maxPoints = teamsToCheck.map((team) => team.points).reduce(max);

    /// Check if the current team has reached the maximum points but is not the last team to play
    return ref.read(currentlyPlayingTeamProvider.notifier).state.points <= maxPoints && currentTeamIndex < teamsToCheck.length - 1;
  }

  /// Game went into tie break, handle accordingly
  void handleTieBreak(List<Team> tiedTeams, {required BuildContext context}) {
    ref.read(tieBreakTeamsProvider.notifier).state = tiedTeams;

    if (tiedTeams.length > 1) {
      continueGame(tiedTeams, context: context);
    } else {
      endGame(tiedTeams.first, context: context);
    }
  }

  /// Continues tie break with proper teams
  void continueGame(List<Team> playingTeams, {required BuildContext context}) {
    updateHiveStats(gameType: Game.none);

    final currentTeamIndex = playingTeams.indexOf(
      ref.read(currentlyPlayingTeamProvider.notifier).state,
    );
    ref.read(currentlyPlayingTeamProvider.notifier).state = currentTeamIndex < playingTeams.length - 1 ? playingTeams[currentTeamIndex + 1] : playingTeams[0];

    showScoresSheet(context);
  }

  /// Ends game and goes to [NormalGameFinishedScreen]
  void endGame(Team winner, {required BuildContext context}) {
    updateHiveStats(gameType: Game.normal);
    goToNormalGameFinishedScreen(context, winner: winner);
  }

  ///
  /// ANSWER
  ///

  void answerChosen({required Answer chosenAnswer}) {
    /// Game is not running, handle tapping answer
    if (ref.read(currentGameProvider.notifier).state == Game.none) {
      start3SecondCountdown();
      return;
    }

    /// Game is starting, don't do anything
    if (ref.read(currentGameProvider.notifier).state == Game.starting) {
      return;
    }

    /// Game is running
    /// 1. Play proper sound
    /// 2. Add an answer to the proper team
    /// 3. Add answer to list of `playedWords` (for showing in the end of the round)
    /// 4. Get another random word

    /// Play proper sound
    playAnswerSound(chosenAnswer: chosenAnswer);

    /// Player chose the `Correct` button
    if (chosenAnswer == Answer.correct) {
      correctAnswers++;
      ref.read(currentlyPlayingTeamProvider.notifier).state
        ..points += 1
        ..correctPoints += 1;
    }

    /// Player chose the `Wrong` button
    else {
      wrongAnswers++;
      ref.read(currentlyPlayingTeamProvider.notifier).state
        ..points -= 1
        ..wrongPoints += 1;
    }

    /// Add answer to list of `playedWords` (for showing in the end of the round)
    ref.read(playedWordsProvider.notifier).state.add(
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
      teams: ref.read(teamsProvider.notifier).state,
      playedWords: ref.read(playedWordsProvider.notifier).state,
      dismissible: false,
      context: context,
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pop();
  }

  ///
  /// HIVE
  ///

  /// Update stats and store them in [Hive]
  void updateHiveStats({required Game gameType}) {
    normalGameStats = normalGameStats.copyWith(
      endTime: gameType == Game.normal ? DateTime.now() : null,
      rounds: [
        ...normalGameStats.rounds,
        Round(
          playedWords: List.from(ref.read(playedWordsProvider.notifier).state),
          playingTeam: ref.read(currentlyPlayingTeamProvider.notifier).state,
        ),
      ],
    );

    if (gameType == Game.normal) {
      ref.read(hiveProvider).addNormalGameStatsToBox(normalGameStats: normalGameStats);
    }
  }
}
