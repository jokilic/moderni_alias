import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/strings.dart';
import '../models/normal_game_stats/normal_game_stats.dart';
import '../models/played_word/played_word.dart';
import '../models/quick_game_stats/quick_game_stats.dart';
import '../models/round/round.dart';
import '../models/team/team.dart';
import '../screens/game_finished/game_finished_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/normal_game/normal_game_screen.dart';
import '../screens/normal_game/widgets/show_scores.dart';
import '../screens/quick_game/quick_game_screen.dart';
import '../screens/quick_game_finished/quick_game_finished_screen.dart';
import 'dictionary_service.dart';

class GameService {
  ///
  /// REACTIVE VARIABLES
  ///

  final _currentGame = Game.none.obs;
  Game get currentGame => _currentGame.value;
  set currentGame(Game value) => _currentGame.value = value;

  final _chosenDictionary = Flag.croatia.obs;
  Flag get chosenDictionary => _chosenDictionary.value;
  set chosenDictionary(Flag value) => _chosenDictionary.value = value;

  final _countdownTimerFillColor = ModerniAliasColors.blueColor.obs;
  Color get countdownTimerFillColor => _countdownTimerFillColor.value;
  set countdownTimerFillColor(Color value) => _countdownTimerFillColor.value = value;

  final _lengthOfRound = 60.obs;
  int get lengthOfRound => _lengthOfRound.value;
  set lengthOfRound(int value) => _lengthOfRound.value = value;

  final _pointsToWin = 50.obs;
  int get pointsToWin => _pointsToWin.value;
  set pointsToWin(int value) => _pointsToWin.value = value;

  final _teams = [for (var i = 0; i < 2; i++) Team(name: '')].obs;
  List<Team> get teams => _teams;
  set teams(List<Team> value) => _teams.assignAll(value);

  final _tieBreakTeams = Rxn<List<Team>?>();
  List<Team>? get tieBreakTeams => _tieBreakTeams.value;
  set tieBreakTeams(List<Team>? value) => _tieBreakTeams.value = value;

  final _currentlyPlayingTeam = Team(name: '').obs;
  Team get currentlyPlayingTeam => _currentlyPlayingTeam.value;
  set currentlyPlayingTeam(Team value) => _currentlyPlayingTeam.value = value;

  final _validationMessage = ''.obs;
  String get validationMessage => _validationMessage.value;
  set validationMessage(String value) => _validationMessage.value = value;

  final _counter3Seconds = 0.obs;
  int get counter3Seconds => _counter3Seconds.value;
  set counter3Seconds(int value) => _counter3Seconds.value = value;

  final _playedWords = <PlayedWord>[].obs;
  List<PlayedWord> get playedWords => _playedWords;
  set playedWords(List<PlayedWord> value) => _playedWords.assignAll(value);

  ///
  /// VARIABLES
  ///

  late final Random random;
  late final AudioPlayer correctPlayer;
  late final AudioPlayer wrongPlayer;
  late final AudioPlayer countdownPlayer;

  late final AnimationController exitButtonAnimationController;

  Timer? greenTimer;
  Timer? yellowTimer;
  Timer? redTimer;
  Timer? soundTimer;

  var correctAnswers = 0;
  var wrongAnswers = 0;

  var teamsValidated = true;

  var greenSeconds = 0.0;
  var yellowSeconds = 0.0;
  var redSeconds = 0.0;

  NormalGameStats? normalGameStats;
  QuickGameStats? quickGameStats;

  ///
  /// INIT
  ///

  @override
  void onInit() {
    super.onInit();

    initValues();
    initAnimation();
  }

  ///
  /// DISPOSE
  ///

  @override
  void onClose() {
    exitButtonAnimationController.dispose();
    super.onClose();
  }

  ///
  /// METHODS
  ///

  /// Initializes relevant variables
  void initValues() {
    random = Random();

    correctPlayer = AudioPlayer()..setAsset(ModerniAliasSounds.correct, preload: false);
    wrongPlayer = AudioPlayer()..setAsset(ModerniAliasSounds.wrong, preload: false);
    countdownPlayer = AudioPlayer()..setAsset(ModerniAliasSounds.timer, preload: false);
  }

  /// Initializes animation used in the [ExitGame] modal
  void initAnimation() {
    exitButtonAnimationController = AnimationController(
      vsync: this,
      duration: ModerniAliasDurations.slowAnimation,
    )..addStatusListener(
        (status) {
          /// Animation is completed, exit game
          if (status == AnimationStatus.completed) {
            exitToMainMenu();
          }
        },
      );
  }

  /// Returns a Timer with the specified length and color
  Timer makeTimer({required double chosenSeconds, required Color chosenColor}) => Timer(
        Duration(seconds: lengthOfRound - chosenSeconds.round()),
        () => countdownTimerFillColor = chosenColor,
      );

  /// Reset variables and start the round
  void startRound({required Game chosenGame}) {
    correctAnswers = 0;
    wrongAnswers = 0;
    playedWords.clear();

    currentGame = chosenGame;
    countdownTimerFillColor = ModerniAliasColors.blueColor;

    Get.find<DictionaryService>().getRandomWord;

    startCountdown();
  }

  /// Called when the validation passes
  /// Starts main game
  void startMainGame() {
    currentGame = Game.none;
    countdownTimerFillColor = Colors.transparent;
    currentlyPlayingTeam = teams.first;
    exitButtonAnimationController.value = 0;
    tieBreakTeams = null;

    normalGameStats = NormalGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      teams: List.from(teams),
      rounds: [],
      lengthOfRound: lengthOfRound,
      pointsToWin: pointsToWin,
      language: chosenDictionary,
    );

    Get.toNamed(NormalGameScreen.routeName);
  }

  /// Starts quick game
  void startQuickGame() {
    currentGame = Game.none;
    countdownTimerFillColor = Colors.transparent;
    lengthOfRound = 60;
    exitButtonAnimationController.value = 0;
    quickGameStats = QuickGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      round: Round(playedWords: []),
      language: chosenDictionary,
    );

    Get.toNamed(QuickGameScreen.routeName);
  }

  /// Round has ended (time has run out)
  void endOfRound({required Game currentGame}) => currentGame == Game.normal ? checkGameWinner() : finishQuickGame();

  /// Check if there's a winner
  /// If no winner, continue the game with the next team
  /// If winner, show the confetti screen
  void checkGameWinner() {
    gameOnHold();

    /// Check if there are teams which have enough points to win the game
    final teamsWithEnoughPoints = getTeamsWithEnoughPoints();

    /// There are no teams with enough points, continue playing the game
    if (teamsWithEnoughPoints.isEmpty) {
      continueGame(teams);
      return;
    }

    ///
    /// There are teams which have enough points to win the game
    ///

    /// Round is not finished, continue playing the game
    if (roundNotDone(tieBreakTeams ?? teams)) {
      continueGame(tieBreakTeams ?? teams);
    }

    /// Round is finished, play tie break if there are tied teams or end game
    else {
      handleTieBreak(getTiedTeams(teamsWithEnoughPoints));
    }
  }

  /// Returns a list of `Teams` who have enough points to win the game
  List<Team> getTeamsWithEnoughPoints() => teams.where((team) => team.points >= pointsToWin).toList();

  /// Checks if current round is finished
  bool roundNotDone(List<Team> teamsToCheck) {
    final currentTeamIndex = teamsToCheck.indexOf(currentlyPlayingTeam);

    /// Find the maximum points among the teams with enough points
    final maxPoints = teamsToCheck.map((team) => team.points).reduce(max);

    /// Check if the current team has reached the maximum points but is not the last team to play
    return currentlyPlayingTeam.points <= maxPoints && currentTeamIndex < teamsToCheck.length - 1;
  }

  /// Game went into tie break, handle accordingly
  void handleTieBreak(List<Team> tiedTeams) {
    tieBreakTeams = tiedTeams;

    if (tiedTeams.length > 1) {
      continueGame(tiedTeams);
    } else {
      endGame(tiedTeams.first);
    }
  }

  /// Continues tie break with proper teams
  void continueGame(List<Team> playingTeams) {
    updateHiveStats(gameType: Game.none);

    final currentTeamIndex = playingTeams.indexOf(currentlyPlayingTeam);
    currentlyPlayingTeam = currentTeamIndex < playingTeams.length - 1 ? playingTeams[currentTeamIndex + 1] : playingTeams[0];

    showScoresSheet();
  }

  /// Ends game and goes to [GameFinishedScreen]
  void endGame(Team winner) {
    updateHiveStats(gameType: Game.normal);
    Get.toNamed(GameFinishedScreen.routeName, arguments: winner);
  }

  // Find all teams that are tied for first place
  List<Team> getTiedTeams(List<Team> teamsWithEnoughPoints) {
    final maxPoints = teamsWithEnoughPoints.map((team) => team.points).reduce(max);
    return teamsWithEnoughPoints.where((team) => team.points == maxPoints).toList();
  }

  /// Goes to the confetti screen and shows info about the round
  void finishQuickGame() {
    gameFinished();
    updateHiveStats(gameType: Game.quick);
    Get.toNamed(QuickGameFinishedScreen.routeName);
  }

  /// Gets called when the game is on hold (round ended, waiting for new round start)
  void gameOnHold() {
    currentGame = Game.none;
    countdownTimerFillColor = Colors.transparent;

    soundTimer?.cancel();
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();
  }

  /// Shows scores sheet and dismisses it after some time
  Future<void> showScoresSheet() async {
    if (Get.context != null) {
      showScores(
        teams: teams,
        playedWords: playedWords,
        dismissible: false,
      );
      await Future.delayed(const Duration(seconds: 3));
      Get.back();
    }
  }

  /// Gets called when the game is fully over (going to main menu)
  void gameFinished() {
    countdownTimerFillColor = Colors.transparent;

    soundTimer?.cancel();
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();
  }

  /// Sets the variables and starts the time countdown
  void startCountdown() {
    /// Set the time when the colors in the circular timer change
    greenSeconds = lengthOfRound * 0.6;
    yellowSeconds = lengthOfRound * 0.4;
    redSeconds = lengthOfRound * 0.15;

    /// Initialize timer that runs when the round is about to end
    soundTimer = Timer(
      Duration(seconds: lengthOfRound - 5),
      () => countdownPlayer
        ..load()
        ..play(),
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
    currentGame = Game.starting;
    counter3Seconds = 3;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        counter3Seconds -= 1;

        if (counter3Seconds == 0) {
          timer.cancel();
        }
      },
    );
  }

  /// Gets called when the user has tapped on the 'Wrong' or 'Correct' button
  /// Increments the relevant variable and generate a new random word
  void answerChosen({required Answer chosenButton}) {
    /// Game is not running, handle tapping answer
    if (currentGame == Game.none) {
      start3SecondCountdown();
      return;
    }

    /// Game is starting, don't do anything
    if (currentGame == Game.starting) {
      return;
    }

    /// Game is running
    /// 1. Play proper sound
    /// 2. Add an answer to the proper team
    /// 3. Add answer to list of `playedWords` (for showing in the end of the round)
    /// 4. Get another random word

    /// Play proper sound
    playAnswerSound(chosenButton: chosenButton);

    /// Add an answer to the proper team
    if (currentGame == Game.quick) {
      chosenButton == Answer.correct ? correctAnswers++ : wrongAnswers++;
    }

    if (currentGame == Game.normal) {
      /// Player chose the `Correct` button
      if (chosenButton == Answer.correct) {
        correctAnswers++;
        currentlyPlayingTeam
          ..points += 1
          ..correctPoints += 1;
      }

      /// Player chose the `Wrong` button
      else {
        wrongAnswers++;
        currentlyPlayingTeam
          ..points -= 1
          ..wrongPoints += 1;
      }

      _currentlyPlayingTeam.refresh();
    }

    /// Add answer to list of `playedWords` (for showing in the end of the round)
    playedWords.add(
      PlayedWord(
        word: Get.find<DictionaryService>().currentWord,
        chosenAnswer: chosenButton,
      ),
    );

    /// Get another random word
    Get.find<DictionaryService>().getRandomWord;
  }

  /// Plays proper sound while pressing on the answers
  void playAnswerSound({required Answer chosenButton}) {
    if (chosenButton == Answer.correct) {
      correctPlayer
        ..load()
        ..play();
    } else {
      wrongPlayer
        ..load()
        ..play();
    }
  }

  /// Called when the user exits the game
  void exitToMainMenu() {
    teams = <Team>[for (var i = 0; i < 2; i++) Team(name: '')];

    gameFinished();
    countdownPlayer.stop();

    Get.offNamedUntil(
      HomeScreen.routeName,
      (route) => false,
    );
  }

  /// Called when the user taps on the flag in StartGame
  void updateDictionary(Flag chosenFlag) {
    chosenDictionary = chosenFlag;
    Get.find<DictionaryService>().refillCurrentDictionary();
  }

  /// Called when the user taps on the points in StartGame
  set updatePointsToWin(int chosenPoints) => pointsToWin = chosenPoints;

  /// Called when the user taps on the length of round in StartGame
  set updateLengthOfRound(int chosenLength) => lengthOfRound = chosenLength;

  /// Called when the user writes on the text field and adds a team name
  void teamNameUpdated({required Team team, required String value}) => team.name = value;

  /// Called when the user taps on the number of teams in StartGame
  void updateNumberOfTeams({required int chosenNumber}) {
    teams
      ..clear()
      ..addAll([for (var i = 0; i < chosenNumber; i++) Team(name: '')]);
  }

  /// Called when the user taps the 'Play' button
  void validateMainGame() {
    teamsValidated = true;

    /// Check if any of team names are same
    final duplicateTeamsList = <Team>[];
    teams.map((team) {
      if (duplicateTeamsList.contains(team)) {
        validationMessage = 'teamNamesSameString'.tr();
        teamsValidated = false;
      } else {
        duplicateTeamsList.add(team);
      }
    }).toList();

    /// Check if any of the teams has an empty name
    teams.map((team) {
      if (team.name.isEmpty) {
        validationMessage = 'teamNamesMissingString'.tr();
        teamsValidated = false;
      }
    }).toList();

    if (teamsValidated) {
      validationMessage = '';
      startMainGame();
    }
  }

  /// Game is finished, update stats and store them in [Hive]
  void updateHiveStats({required Game gameType}) {
    /// Normal game was played
    if (gameType == Game.normal) {
      if (normalGameStats != null) {
        normalGameStats = normalGameStats!.copyWith(
          endTime: DateTime.now(),
          rounds: [
            ...normalGameStats!.rounds,
            Round(
              playedWords: List.from(playedWords),
              playingTeam: currentlyPlayingTeam,
            ),
          ],
        );
        hiveService.addNormalGameStatsToBox(normalGameStats: normalGameStats!);
      }
    }

    /// Quick game was played
    if (gameType == Game.quick) {
      if (quickGameStats != null) {
        quickGameStats = quickGameStats!.copyWith(
          round: Round(playedWords: List.from(playedWords)),
          endTime: DateTime.now(),
        );
        hiveService.addQuickGameStatsToBox(quickGameStats: quickGameStats!);
        quickGameStats = null;
      }
    }

    /// Normal game is played, but the round ended
    if (gameType == Game.none) {
      if (normalGameStats != null) {
        normalGameStats = normalGameStats!.copyWith(
          rounds: [
            ...normalGameStats!.rounds,
            Round(
              playedWords: List.from(playedWords),
              playingTeam: currentlyPlayingTeam,
            ),
          ],
        );
      }
    }
  }
}
