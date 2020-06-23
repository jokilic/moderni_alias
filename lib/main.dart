import 'package:flutter/material.dart';

import 'colors.dart';
import './screens/home_page/home_page_screen.dart';
import './screens/how_to_play/how_to_play_screen.dart';
import './screens/start_game/start_game_screen.dart';
import './screens/playing_game/playing_game_screen.dart';
import './screens/game_finished/game_finished.dart';

void main() => runApp(ModerniAlias());

class ModerniAlias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        StartGame.routeName: (context) => StartGame(),
        HowToPlay.routeName: (context) => HowToPlay(),
        PlayingGame.routeName: (context) => PlayingGame(),
        GameFinished.routeName: (context) => GameFinished(),
      },
      theme: ThemeData(
        primaryColor: darkColor,
        accentColor: yellowColor,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: darkColor,
        fontFamily: 'Roboto Slab',
        textTheme: TextTheme(
            headline1: TextStyle(
              color: textColor,
              fontSize: 58.0,
            ),
            headline2: TextStyle(
              color: textColor,
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              color: textColor,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              color: textColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: textColor,
              fontSize: 16.0,
            ),
            button: TextStyle(
              color: textColor,
            ),
            headline6: TextStyle(
              color: textColor,
              fontSize: 58.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 8.0,
            )),
      ),
    );
  }
}
