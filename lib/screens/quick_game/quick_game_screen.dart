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
late double quickGreenSeconds;
late double quickYellowSeconds;
late double quickRedSeconds;
Timer? quickGreenTimer;
Timer? quickYellowTimer;
Timer? quickRedTimer;
Timer? quickSoundTimer;
bool simpleGamePlaying = false;
Map<String, String> routeArguments = {};
final AudioPlayer buttonQuickAudioPlayer = AudioPlayer();
final AudioPlayer countdownQuickAudioPlayer = AudioPlayer();
final AudioCache buttonQuickPlayer =
    AudioCache(fixedPlayer: buttonQuickAudioPlayer);
final AudioCache countdownQuickPlayer =
    AudioCache(fixedPlayer: countdownQuickAudioPlayer);

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
  Timer makeTimer(double chosenSeconds, Color chosenColor) {
    return Timer(Duration(seconds: lengthOfRound - chosenSeconds.round()), () {
      setState(() {
        countdownTimerFillColor = chosenColor;
      });
    });
  }

  void startCountdown() {
    quickGreenSeconds = lengthOfRound * 0.6;
    quickYellowSeconds = lengthOfRound * 0.4;
    quickRedSeconds = lengthOfRound * 0.15;

    quickSoundTimer = Timer(Duration(seconds: lengthOfRound - 5),
        () => countdownQuickPlayer.play('timer.ogg'));

    quickGreenTimer = makeTimer(quickGreenSeconds, greenColor);
    quickYellowTimer = makeTimer(quickYellowSeconds, yellowColor);
    quickRedTimer = makeTimer(quickRedSeconds, redColor);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void startGame() {
      correctAnswers = 0;
      wrongAnswers = 0;
      simpleGamePlaying = true;
      currentWord = getRandomWord;
      countdownTimerFillColor = blueColor;
      startCountdown();
      setState(() {});
    }

    void answerChosen(ChosenButton chosenButton) {
      if (simpleGamePlaying) {
        if (chosenButton == ChosenButton.Correct) {
          buttonQuickPlayer.play('correct.ogg');
          correctAnswers++;
        } else {
          buttonQuickPlayer.play('wrong.ogg');
          wrongAnswers++;
        }
        currentWord = getRandomWord;
        setState(() {});
      }
    }

    void endOfGame() {
      simpleGamePlaying = false;
      countdownTimerFillColor = darkBlueColor;
      quickSoundTimer!.cancel();

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
                  child: InfoSection(
                    exitGame: () => exitGame(context),
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
