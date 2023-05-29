import 'package:flutter/material.dart';

import 'models/team/team.dart';
import 'screens/game_finished/game_finished_screen.dart';
import 'screens/general_info/general_info_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/how_to_play/how_to_play_screen.dart';
import 'screens/normal_game/normal_game_screen.dart';
import 'screens/normal_game_stats/normal_game_stats_screen.dart';
import 'screens/quick_game/quick_game_screen.dart';
import 'screens/quick_game_finished/quick_game_finished_screen.dart';
import 'screens/quick_game_stats/quick_game_stats_screen.dart';
import 'screens/start_game/start_game_screen.dart';
import 'screens/stats/stats_screen.dart';

final routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  GameFinishedScreen.routeName: (context) => GameFinishedScreen(winningTeam: Team(name: '')),
  GeneralInfoScreen.routeName: (context) => GeneralInfoScreen(),
  HowToPlayScreen.routeName: (context) => HowToPlayScreen(),
  NormalGameScreen.routeName: (context) => NormalGameScreen(),
  QuickGameScreen.routeName: (context) => QuickGameScreen(),
  QuickGameFinishedScreen.routeName: (context) => QuickGameFinishedScreen(),
  StartGameScreen.routeName: (context) => StartGameScreen(),
  StatsScreen.routeName: (context) => StatsScreen(),
  NormalGameStatsScreen.routeName: (context) => NormalGameStatsScreen(),
  QuickGameStatsScreen.routeName: (context) => QuickGameStatsScreen(),
};

void goToHomeScreen(BuildContext context, {bool popEverything = false}) => !popEverything
    ? Navigator.of(context).pushNamed(
        HomeScreen.routeName,
      )
    : Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (_) => false,
      );
void goToGameFinishedScreen(BuildContext context) => Navigator.of(context).pushNamed(
      GameFinishedScreen.routeName,
    );
void goToGeneralInfoScreen(BuildContext context) => Navigator.of(context).pushNamed(
      GeneralInfoScreen.routeName,
    );
void goToHowToPlayScreen(BuildContext context) => Navigator.of(context).pushNamed(
      HowToPlayScreen.routeName,
    );
void goToNormalGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      NormalGameScreen.routeName,
    );
void goToQuickGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      QuickGameScreen.routeName,
    );
void goToQuickGameFinishedScreen(BuildContext context) => Navigator.of(context).pushNamed(
      QuickGameFinishedScreen.routeName,
    );
void goToStartGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      StartGameScreen.routeName,
    );
void goToStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      StatsScreen.routeName,
    );
void goToNormalGameStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      NormalGameStatsScreen.routeName,
    );
void goToQuickGameStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      QuickGameStatsScreen.routeName,
    );
