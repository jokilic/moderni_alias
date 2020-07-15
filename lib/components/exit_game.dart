import 'package:flutter/material.dart';

import '../colors.dart';
import '../strings.dart';
import '../screens/playing_game/playing_game_screen.dart';
import './exit_game_button.dart';
import '../screens/home_page/home_page_screen.dart';
import '../screens/quick_game/quick_game_screen.dart';

Future<bool> exitGame(BuildContext context) {
  return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  exitModalQuestionString,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ExitGameButton(
                        text: exitModalQuestionYes,
                        onPressed: () {
                          gamePlaying = false;
                          simpleGamePlaying = false;
                          if (timer != null) timer.cancel();
                          if (quickTimer != null) quickTimer.cancel();
                          countdownAudioPlayer.stop();
                          countdownQuickAudioPlayer.stop();
                          countdownTimerFillColor =
                              countdownTimerFillColorNormalGame;
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(HomePage.routeName),
                          );
                        }),
                    SizedBox(width: 24.0),
                    ExitGameButton(
                      text: exitModalQuestionNo,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  backgroundImage,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
          );
        },
      ) ??
      false;
}
