import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

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
Map<String, String> routeArguments = {};

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
  final AudioCache player = AudioCache();
  String pointsToWin;
  String lengthOfRound;
  List<String> routeTeams;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    pointsToWin = routeArguments['pointsToWin'];
    lengthOfRound = routeArguments['lengthOfRound'];
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

  @override
  Widget build(BuildContext context) {
    void startGame() {
      correctAnswers = 0;
      wrongAnswers = 0;
      currentScore = 0;
      gamePlaying = true;
      currentWord = getRandomWord;
      setState(() {});
    }

    void answerChosen(ChosenButton chosenButton) {
      if (gamePlaying) {
        if (chosenButton == ChosenButton.Correct) {
          player.play('correct.ogg');
          correctAnswers++;
        } else {
          player.play('wrong.ogg');
          wrongAnswers++;
        }
        currentWord = getRandomWord;
        setState(() {});
      }
    }

    void endOfRound() {
      gamePlaying = false;
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
      onWillPop: () async => false,
      child: Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                PlayingTeamInfo(
                  showScores: () => showScores(context),
                  exitGame: () => exitGame(context),
                ),
                gamePlaying
                    ? GameOn(
                        onComplete: endOfRound,
                      )
                    : GameOff(
                        onTap: startGame,
                      ),
                WrongCorrectButtons(
                  wrongChosen: () => answerChosen(ChosenButton.Wrong),
                  correctChosen: () => answerChosen(ChosenButton.Correct),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
