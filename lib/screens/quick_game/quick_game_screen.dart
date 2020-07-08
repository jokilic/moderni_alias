import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import '../../colors.dart';
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
int lengthOfRound = 60;
int finalSecondsInRound = 5;
bool simpleGamePlaying = false;
Timer quickTimer;
final AudioPlayer quickAudioPlayer = AudioPlayer();
final AudioCache quickPlayer = AudioCache(fixedPlayer: quickAudioPlayer);
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
  void startCountdown() {
    quickTimer =
        Timer(Duration(seconds: lengthOfRound - finalSecondsInRound), () {
      quickPlayer.play('timer.ogg');
      setState(() {
        countdownTimerFillColor = countdownTimerFillColorFinalSeconds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void startGame() {
      correctAnswers = 0;
      wrongAnswers = 0;
      simpleGamePlaying = true;
      currentWord = getRandomWord;
      countdownTimerFillColor = countdownTimerFillColorNormalGame;
      startCountdown();
      setState(() {});
    }

    void answerChosen(ChosenButton chosenButton) {
      if (simpleGamePlaying) {
        if (chosenButton == ChosenButton.Correct) {
          quickPlayer.play('correct.ogg');
          correctAnswers++;
        } else {
          quickPlayer.play('wrong.ogg');
          wrongAnswers++;
        }
        currentWord = getRandomWord;
        setState(() {});
      }
    }

    void endOfGame() {
      simpleGamePlaying = false;
      countdownTimerFillColor = countdownTimerFillColorNormalGame;
      quickTimer.cancel();

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
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  width: size.width,
                  child: InfoSection(
                    exitGame: () {
                      exitGame(context);
                    },
                    correctAnswers: correctAnswers,
                    wrongAnswers: wrongAnswers,
                  ),
                ),
                simpleGamePlaying
                    ? Positioned(
                        top: -75.0,
                        bottom: 0.0,
                        child: GameOn(
                          length: lengthOfRound,
                          onComplete: endOfGame,
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
