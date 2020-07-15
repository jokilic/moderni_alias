import 'package:flutter/material.dart';

import 'colors.dart';
import './screens/home_page/home_page_screen.dart';
import './screens/general_info/general_info_screen.dart';
import './screens/how_to_play/how_to_play_screen.dart';
import './screens/start_game/start_game_screen.dart';
import './screens/playing_game/playing_game_screen.dart';
import './screens/game_finished/game_finished.dart';
import './screens/quick_game/quick_game_screen.dart';
import './screens/quick_game_finished/quick_game_finished.dart';

void main() => runApp(ModerniAlias());

class ModerniAlias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        GeneralInfo.routeName: (context) => GeneralInfo(),
        StartGame.routeName: (context) => StartGame(),
        HowToPlay.routeName: (context) => HowToPlay(),
        PlayingGame.routeName: (context) => PlayingGame(),
        GameFinished.routeName: (context) => GameFinished(),
        QuickGame.routeName: (context) => QuickGame(),
        QuickGameFinished.routeName: (context) => QuickGameFinished(),
      },
      theme: ThemeData(
        primaryColor: darkBlueColor,
        accentColor: blueColor,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: darkBlueColor,
        fontFamily: 'Sen',
        textTheme: TextTheme(
          headline1: TextStyle(
            color: whiteColor,
            fontSize: 50.0,
          ),
          headline2: TextStyle(
            color: whiteColor,
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: whiteColor,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: whiteColor,
            fontSize: 54.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 8.0,
          ),
          bodyText1: TextStyle(
            color: whiteColor,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: whiteColor,
            fontSize: 14.0,
          ),
          headline4: TextStyle(
            color: whiteColor,
            fontSize: 20.0,
            height: 1.4,
          ),
          button: TextStyle(
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
