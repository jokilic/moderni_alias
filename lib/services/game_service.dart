import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../models/team.dart';
import '../screens/game_finished/game_finished_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/main_game/main_game_screen.dart';
import '../screens/quick_game/quick_game_screen.dart';
import '../screens/quick_game_finished/quick_game_finished_screen.dart';
import 'dictionary_service.dart';
import 'logger_service.dart';

class GameService extends GetxService {
  /// ------------------------
  /// LOGGER
  /// ------------------------

  final logger = Get.find<LoggerService>();

  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final Random _random;

  final _currentGame = Game.none.obs;
  final _chosenDictionary = Flag.croatia.obs;
  final _countdownTimerFillColor = darkBlueColor.obs;

  final _correctAnswers = 0.obs;
  final _wrongAnswers = 0.obs;
  final _lengthOfRound = 60.obs;
  final _pointsToWin = 50.obs;

  final _teams = <Team>[for (var i = 0; i < 2; i++) Team(name: '')].obs;
  final _currentlyPlayingTeam = Team(name: '').obs;

  final _teamsValidated = true.obs;
  final _gameStarted = true.obs;

  final _greenSeconds = 0.0.obs;
  final _yellowSeconds = 0.0.obs;
  final _redSeconds = 0.0.obs;

  late Timer _greenTimer;
  late Timer _yellowTimer;
  late Timer _redTimer;
  late Timer _soundTimer;

  late AudioPlayer _buttonAudioPlayer;
  late AudioPlayer _countdownAudioPlayer;

  late AudioCache _buttonPlayer;
  late AudioCache _countdownPlayer;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  Random get random => _random;

  Game get currentGame => _currentGame.value;
  Flag get chosenDictionary => _chosenDictionary.value;
  Color get countdownTimerFillColor => _countdownTimerFillColor.value;

  int get correctAnswers => _correctAnswers.value;
  int get wrongAnswers => _wrongAnswers.value;
  int get lengthOfRound => _lengthOfRound.value;
  int get pointsToWin => _pointsToWin.value;

  List<Team> get teams => _teams;
  Team get currentlyPlayingTeam => _currentlyPlayingTeam.value;

  bool get teamsValidated => _teamsValidated.value;
  bool get gameStarted => _gameStarted.value;

  double get greenSeconds => _greenSeconds.value;
  double get yellowSeconds => _yellowSeconds.value;
  double get redSeconds => _redSeconds.value;

  Timer get greenTimer => _greenTimer;
  Timer get yellowTimer => _yellowTimer;
  Timer get redTimer => _redTimer;
  Timer get soundTimer => _soundTimer;

  AudioPlayer get buttonAudioPlayer => _buttonAudioPlayer;
  AudioPlayer get countdownAudioPlayer => _countdownAudioPlayer;

  AudioCache get buttonPlayer => _buttonPlayer;
  AudioCache get countdownPlayer => _countdownPlayer;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set random(Random value) => _random = value;

  set currentGame(Game value) => _currentGame.value = value;
  set chosenDictionary(Flag value) => _chosenDictionary.value = value;
  set countdownTimerFillColor(Color value) => _countdownTimerFillColor.value = value;

  set correctAnswers(int value) => _correctAnswers.value = value;
  set wrongAnswers(int value) => _wrongAnswers.value = value;
  set lengthOfRound(int value) => _lengthOfRound.value = value;
  set pointsToWin(int value) => _pointsToWin.value = value;

  set teams(List<Team> value) => _teams.assignAll(value);
  set currentlyPlayingTeam(Team value) => _currentlyPlayingTeam.value = value;

  set teamsValidated(bool value) => _teamsValidated.value = value;
  set gameStarted(bool value) => _gameStarted.value = value;

  set greenSeconds(double value) => _greenSeconds.value = value;
  set yellowSeconds(double value) => _yellowSeconds.value = value;
  set redSeconds(double value) => _redSeconds.value = value;

  set greenTimer(Timer value) => _greenTimer = value;
  set yellowTimer(Timer value) => _yellowTimer = value;
  set redTimer(Timer value) => _redTimer = value;
  set soundTimer(Timer value) => _soundTimer = value;

  set buttonAudioPlayer(AudioPlayer value) => _buttonAudioPlayer = value;
  set countdownAudioPlayer(AudioPlayer value) => _countdownAudioPlayer = value;

  set buttonPlayer(AudioCache value) => _buttonPlayer = value;
  set countdownPlayer(AudioCache value) => _countdownPlayer = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();
    initValues();
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Initializes relevant variables
  void initValues() {
    random = Random();

    buttonAudioPlayer = AudioPlayer();
    countdownAudioPlayer = AudioPlayer();

    buttonPlayer = AudioCache(fixedPlayer: buttonAudioPlayer);
    countdownPlayer = AudioCache(fixedPlayer: countdownAudioPlayer);
  }

  /// Returns a Timer with the specified length and color
  Timer makeTimer({required double chosenSeconds, required Color chosenColor}) => Timer(
        Duration(seconds: lengthOfRound - chosenSeconds.round()),
        () => Get.find<GameService>().countdownTimerFillColor = chosenColor,
      );

  /// Reset variables and start the round
  void startRound({required Game chosenGame}) {
    gameStarted = true;

    correctAnswers = 0;
    wrongAnswers = 0;

    currentGame = chosenGame;
    countdownTimerFillColor = blueColor;

    Get.find<DictionaryService>().getRandomWord;

    startCountdown();
  }

  /// Called when the validation passes
  /// Starts main game
  void startMainGame() {
    gameStarted = false;
    currentlyPlayingTeam = teams[random.nextInt(teams.length)];
    Get.toNamed(MainGameScreen.routeName);
  }

  /// Starts quick game
  void startQuickGame() {
    gameStarted = false;
    lengthOfRound = 60;
    Get.toNamed(QuickGameScreen.routeName);
  }

  /// Round has ended (time has run out)
  void endOfRound({required Game currentGame}) => currentGame == Game.normal ? checkGameWinner() : finishQuickGame();

  /// Check if there's a winner
  /// If no winner, continue the game with the next team
  /// If winner, show the confetti screen
  void checkGameWinner() {
    gameOnHold();

    /// Check if there's a winner and act accordingly
    if (currentlyPlayingTeam.points >= pointsToWin) {
      Get.toNamed(GameFinishedScreen.routeName);
    } else {
      /// Let the next team play
      final currentTeamIndex = teams.indexOf(currentlyPlayingTeam);
      currentTeamIndex < teams.length - 1
          ? currentlyPlayingTeam = teams[currentTeamIndex + 1]
          : currentlyPlayingTeam = teams[0];
    }
  }

  /// Goes to the confetti screen and shows info about the round
  void finishQuickGame() {
    gameOnHold();
    Get.toNamed(QuickGameFinishedScreen.routeName);
  }

  /// Gets called when the game is on hold (round ended, waiting for new round start)
  void gameOnHold() => Get.find<GameService>()
    ..currentGame = Game.none
    ..countdownTimerFillColor = darkBlueColor
    ..soundTimer.cancel()
    ..greenTimer.cancel()
    ..yellowTimer.cancel()
    ..redTimer.cancel();

  /// Sets the variables and starts the time countdown
  void startCountdown() {
    /// Set the time when the colors in the circular timer change
    greenSeconds = lengthOfRound * 0.6;
    yellowSeconds = lengthOfRound * 0.4;
    redSeconds = lengthOfRound * 0.15;

    /// Initialize timer that runs when the round is about to end
    soundTimer = Timer(
      Duration(seconds: lengthOfRound - 5),
      () => countdownPlayer.play('timer.ogg'),
    );

    /// Initialize timers that change colors
    greenTimer = makeTimer(
      chosenSeconds: greenSeconds,
      chosenColor: greenColor,
    );
    yellowTimer = makeTimer(
      chosenSeconds: yellowSeconds,
      chosenColor: yellowColor,
    );
    redTimer = makeTimer(
      chosenSeconds: redSeconds,
      chosenColor: redColor,
    );
  }

  /// Gets called when the user has tapped on the 'Wrong' or 'Correct' button
  /// Increments the relevant variable and generate a new random word
  void answerChosen({required Answer chosenButton}) {
    if (currentGame != Game.none) {
      playAnswerSound(chosenButton: chosenButton);
    } else {
      /// TODO: Sad sound if the user presses on the answer buttons
      /// and the game hasn't started.
      ///
      /// Maybe even me saying 'Stisni gore...'

      // buttonPlayer.play(fileName);
    }

    if (currentGame == Game.quick) {
      chosenButton == Answer.correct ? correctAnswers++ : wrongAnswers++;
    }

    if (currentGame == Game.normal) {
      chosenButton == Answer.correct
          ? _currentlyPlayingTeam.value.points += 1
          : _currentlyPlayingTeam.value.points -= 1;

      _currentlyPlayingTeam.refresh();
    }

    Get.find<DictionaryService>().getRandomWord;
  }

  /// Plays proper sound while pressing on the answers
  void playAnswerSound({required Answer chosenButton}) =>
      chosenButton == Answer.correct ? buttonPlayer.play('correct.ogg') : buttonPlayer.play('wrong.ogg');

  /// Called when the user exits the game
  void exitToMainMenu() {
    currentGame = Game.none;

    teams = <Team>[for (var i = 0; i < 2; i++) Team(name: '')];

    if (gameStarted) {
      soundTimer.cancel();
      greenTimer.cancel();
      yellowTimer.cancel();
      redTimer.cancel();
    }

    countdownAudioPlayer.stop();

    countdownTimerFillColor = darkBlueColor;

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
  void teamNameUpdated({required int index, required String value}) => teams[index].name = value;

  /// Called when the user taps on the number of teams in StartGame
  void updateNumberOfTeams({required int chosenNumber}) {
    teams
      ..clear()
      ..addAll([for (var i = 0; i < chosenNumber; i++) Team(name: '')]);
  }

  /// Called when the user taps the 'Play' button
  void validateMainGame() {
    teamsValidated = true;

    teams.map((team) {
      if (team.name.isEmpty) {
        teamsValidated = false;
      }
    }).toList();

    if (teamsValidated) {
      startMainGame();
    }
  }
}
