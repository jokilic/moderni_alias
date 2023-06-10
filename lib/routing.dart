import 'package:flutter/material.dart';

import 'models/team/team.dart';
import 'screens/general_info/general_info_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/how_to_play/how_to_play_screen.dart';
import 'screens/normal_game/normal_game_screen.dart';
import 'screens/normal_game_finished/normal_game_finished_screen.dart';
import 'screens/normal_game_stats/normal_game_stats_screen.dart';
import 'screens/quick_game/quick_game_screen.dart';
import 'screens/quick_game_finished/quick_game_finished_screen.dart';
import 'screens/quick_game_stats/quick_game_stats_screen.dart';
import 'screens/start_game/start_game_screen.dart';
import 'screens/stats/stats_screen.dart';

final routes = {
  ModerniAliasRoutes.homeScreen: (context) => HomeScreen(),
  ModerniAliasRoutes.generalInfoScreen: (context) => GeneralInfoScreen(),
  ModerniAliasRoutes.howToPlayScreen: (context) => HowToPlayScreen(),
  ModerniAliasRoutes.startGameScreen: (context) => StartGameScreen(),
  ModerniAliasRoutes.normalGameScreen: (context) => NormalGameScreen(),
  ModerniAliasRoutes.normalGameFinishedScreen: (context) => NormalGameFinishedScreen(winningTeam: Team(name: '')),
  ModerniAliasRoutes.quickGameScreen: (context) => QuickGameScreen(),
  ModerniAliasRoutes.quickGameFinishedScreen: (context) => QuickGameFinishedScreen(),
  ModerniAliasRoutes.statsScreen: (context) => StatsScreen(),
  ModerniAliasRoutes.normalGameStatsScreen: (context) => NormalGameStatsScreen(),
  ModerniAliasRoutes.quickGameStatsScreen: (context) => QuickGameStatsScreen(),
};

class ModerniAliasRoutes {
  static const homeScreen = '/home';
  static const generalInfoScreen = '/general_info';
  static const howToPlayScreen = '/how_to_play';
  static const startGameScreen = '/start_game';
  static const normalGameScreen = '/normal_game';
  static const normalGameFinishedScreen = '/normal_game_finished';
  static const quickGameScreen = '/quick_game';
  static const quickGameFinishedScreen = '/quick_game_finished';
  static const statsScreen = '/stats';
  static const normalGameStatsScreen = '/normal_game_stats';
  static const quickGameStatsScreen = '/quick_game_stats';
}

///
void goToHomeScreen(BuildContext context, {bool popEverything = false}) => !popEverything
    ? Navigator.of(context).pushNamed(
        ModerniAliasRoutes.homeScreen,
      )
    : Navigator.of(context).pushNamedAndRemoveUntil(
        ModerniAliasRoutes.homeScreen,
        (_) => false,
      );

///
void goToGeneralInfoScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.generalInfoScreen,
    );

///
void goToHowToPlayScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.howToPlayScreen,
    );

///
void goToStartGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.startGameScreen,
    );

///
void goToNormalGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.normalGameScreen,
    );

///
void goToNormalGameFinishedScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.normalGameFinishedScreen,
    );

///
void goToQuickGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.quickGameScreen,
    );

///
void goToQuickGameFinishedScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.quickGameFinishedScreen,
    );

///
void goToStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.statsScreen,
    );

///
void goToNormalGameStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.normalGameStatsScreen,
    );

///
void goToQuickGameStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.quickGameStatsScreen,
    );
