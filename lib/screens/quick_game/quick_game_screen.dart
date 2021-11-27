import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './widgets/info_section.dart';
import '../../constants/colors.dart';
import '../../models/dictionary.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_on.dart';
import '../../widgets/wrong_correct_buttons.dart';
import '../quick_game_finished/quick_game_finished_screen.dart';

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
final AudioCache buttonQuickPlayer = AudioCache(fixedPlayer: buttonQuickAudioPlayer);
final AudioCache countdownQuickPlayer = AudioCache(fixedPlayer: countdownQuickAudioPlayer);

enum ChosenButton {
  correct,
  wrong,
}

class QuickGameScreen extends StatefulWidget {
  static const routeName = '/quick-game-screen';

  @override
  _QuickGameScreenState createState() => _QuickGameScreenState();
}

class _QuickGameScreenState extends State<QuickGameScreen> {
  Timer makeTimer(double chosenSeconds, Color chosenColor) => Timer(
        Duration(seconds: lengthOfRound - chosenSeconds.round()),
        () => setState(() => countdownTimerFillColor = chosenColor),
      );

  void startCountdown() {
    quickGreenSeconds = lengthOfRound * 0.6;
    quickYellowSeconds = lengthOfRound * 0.4;
    quickRedSeconds = lengthOfRound * 0.15;

    quickSoundTimer = Timer(Duration(seconds: lengthOfRound - 5), () => countdownQuickPlayer.play('timer.ogg'));

    quickGreenTimer = makeTimer(quickGreenSeconds, greenColor);
    quickYellowTimer = makeTimer(quickYellowSeconds, yellowColor);
    quickRedTimer = makeTimer(quickRedSeconds, redColor);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        if (chosenButton == ChosenButton.correct) {
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
      quickSoundTimer?.cancel();

      routeArguments = {
        'correctAnswers': correctAnswers.toString(),
        'wrongAnswers': wrongAnswers.toString(),
      };

      Get.toNamed(QuickGameFinishedScreen.routeName);
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
                  top: 0,
                  width: size.width,
                  child: InfoSection(
                    exitGame: () => exitGame(context),
                    correctAnswers: correctAnswers,
                    wrongAnswers: wrongAnswers,
                  ),
                ),
                if (simpleGamePlaying)
                  Positioned(
                    top: -75,
                    bottom: 0,
                    child: GameOn(
                      length: lengthOfRound,
                      onComplete: endOfGame,
                    ),
                  )
                else
                  Positioned(
                    top: -75,
                    bottom: 0,
                    child: GameOff(
                      onTap: startGame,
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  width: size.width,
                  child: WrongCorrectButtons(
                    wrongChosen: () => answerChosen(ChosenButton.wrong),
                    correctChosen: () => answerChosen(ChosenButton.correct),
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
