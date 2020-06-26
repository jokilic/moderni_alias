import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

import '../../models/dictionary.dart';
import '../../components/background_image.dart';
import './components/info_section.dart';
import '../../components/exit_game.dart';
import '../../components/game_off.dart';
import '../../components/game_on.dart';
import '../../components/wrong_correct_buttons.dart';
import '../quick_game_finished/quick_game_finished.dart';

int wrongAnswers = 0;
int correctAnswers = 0;
bool simpleGamePlaying = false;
Map<String, String> routeArguments = {};

enum ChosenButton {
  Correct,
  Wrong,
}

class QuickGame extends StatefulWidget {
  static const routeName = '/quick-game';

  @override
  _QuickGameState createState() => _QuickGameState();
}

class _QuickGameState extends State<QuickGame> {
  final AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    void startGame() {
      correctAnswers = 0;
      wrongAnswers = 0;
      simpleGamePlaying = true;
      currentWord = getRandomWord;
      setState(() {});
    }

    void answerChosen(ChosenButton chosenButton) {
      if (simpleGamePlaying) {
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

    void endOfGame() {
      simpleGamePlaying = false;
      routeArguments = {
        'correctAnswers': correctAnswers.toString(),
        'wrongAnswers': wrongAnswers.toString(),
      };

      Navigator.pushNamed(
        context,
        QuickGameFinished.routeName,
        arguments: routeArguments,
      );
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
                InfoSection(
                  exitGame: () {
                    exitGame(context);
                  },
                  correctAnswers: correctAnswers,
                  wrongAnswers: wrongAnswers,
                ),
                simpleGamePlaying
                    ? GameOn(
                        onComplete: endOfGame,
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
