import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import '../../colors.dart';
import '../../components/background_image.dart';
import './components/playing_team_info.dart';
import './components/show_scores.dart';
import '../../components/exit_game.dart';
import '../../components/game_off.dart';
import '../../components/game_on.dart';
import '../../components/wrong_correct_buttons.dart';
import '../game_finished/game_finished.dart';
import '../../models/dictionary.dart';
import '../../models/team.dart';

List<Team> teams = [];
bool gamePlaying = false;
Team currentlyPlayingTeam;
int currentlyPlayingIndex = 0;
int wrongAnswers = 0;
int correctAnswers = 0;
int currentScore = 0;
int lengthOfRound;
Map<String, String> routeArguments = {};
double greenSeconds;
double yellowSeconds;
double redSeconds;
Timer greenTimer;
Timer yellowTimer;
Timer redTimer;
Timer soundTimer;
final AudioPlayer buttonAudioPlayer = AudioPlayer();
final AudioPlayer countdownAudioPlayer = AudioPlayer();
final AudioCache buttonPlayer = AudioCache(fixedPlayer: buttonAudioPlayer);
final AudioCache countdownPlayer =
    AudioCache(fixedPlayer: countdownAudioPlayer);

enum ChosenButton {
  Correct,
  Wrong,
}

class PlayingGame extends StatefulWidget {
  static const routeName = '/playing-game';

  @override
  _PlayingGameState createState() => _PlayingGameState();
}

class _PlayingGameState extends State<PlayingGame> {
  String pointsToWin;
  String lengthOfRoundString;
  List<String> routeTeams;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    pointsToWin = routeArguments['pointsToWin'];
    lengthOfRoundString = routeArguments['lengthOfRound'];
    lengthOfRound = int.parse(lengthOfRoundString);
    routeTeams = [
      routeArguments['team1'],
      routeArguments['team2'],
      routeArguments['team3'],
      routeArguments['team4'],
    ];

    teams.clear();
    int teamIndex = 0;
    routeTeams.removeWhere((value) => value == null);
    routeTeams.forEach((team) {
      teams.add(Team(name: routeTeams[teamIndex]));
      teamIndex++;
    });
    currentlyPlayingTeam = teams[currentlyPlayingIndex];
  }

  Timer makeTimer(double chosenSeconds, Color chosenColor) {
    return Timer(Duration(seconds: lengthOfRound - chosenSeconds.round()), () {
      setState(() {
        countdownTimerFillColor = chosenColor;
      });
    });
  }

  void startCountdown() {
    greenSeconds = lengthOfRound * 0.6;
    yellowSeconds = lengthOfRound * 0.4;
    redSeconds = lengthOfRound * 0.15;

    soundTimer = Timer(Duration(seconds: lengthOfRound - 5),
        () => countdownPlayer.play('timer.ogg'));

    greenTimer = makeTimer(greenSeconds, greenColor);
    yellowTimer = makeTimer(yellowSeconds, yellowColor);
    redTimer = makeTimer(redSeconds, redColor);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void startGame() {
      correctAnswers = 0;
      wrongAnswers = 0;
      currentScore = 0;
      gamePlaying = true;
      countdownTimerFillColor = blueColor;
      currentWord = getRandomWord;
      startCountdown();
      setState(() {});
    }

    void answerChosen(ChosenButton chosenButton) {
      if (gamePlaying) {
        if (chosenButton == ChosenButton.Correct) {
          buttonPlayer.play('correct.ogg');
          correctAnswers++;
        } else {
          buttonPlayer.play('wrong.ogg');
          wrongAnswers++;
        }
        currentWord = getRandomWord;
        setState(() {});
      }
    }

    void endOfRound() {
      gamePlaying = false;
      countdownTimerFillColor = darkBlueColor;
      soundTimer.cancel();
      greenTimer.cancel();
      yellowTimer.cancel();
      redTimer.cancel();

      teams[currentlyPlayingIndex].points += correctAnswers - wrongAnswers;
      if (teams[currentlyPlayingIndex].points >= int.parse(pointsToWin)) {
        routeArguments = {
          'winningTeam': teams[currentlyPlayingIndex].name,
          'points': teams[currentlyPlayingIndex].points.toString(),
        };

        Navigator.pushNamed(
          context,
          GameFinished.routeName,
          arguments: routeArguments,
        );
      }

      if (currentlyPlayingIndex < teams.length - 1) {
        currentlyPlayingIndex++;
        currentlyPlayingTeam = teams[currentlyPlayingIndex];
      } else {
        currentlyPlayingIndex = 0;
        currentlyPlayingTeam = teams[currentlyPlayingIndex];
      }
      setState(() {});
    }

    return WillPopScope(
      onWillPop: () => exitGame(context),
      child: Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  width: size.width,
                  child: PlayingTeamInfo(
                    exitGame: () => exitGame(context),
                    showScores: () => showScores(context),
                  ),
                ),
                gamePlaying
                    ? Positioned(
                        top: -75.0,
                        bottom: 0.0,
                        child: GameOn(
                          length: lengthOfRound,
                          onComplete: endOfRound,
                        ),
                      )
                    : Positioned(
                        top: -75.0,
                        bottom: 0.0,
                        child: GameOff(
                          onTap: startGame,
                        ),
                      ),
                Positioned(
                  bottom: 0.0,
                  width: size.width,
                  child: WrongCorrectButtons(
                    wrongChosen: () => answerChosen(ChosenButton.Wrong),
                    correctChosen: () => answerChosen(ChosenButton.Correct),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
