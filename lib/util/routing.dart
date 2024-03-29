import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/general_info/general_info_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/how_to_play/how_to_play_screen.dart';
import '../screens/normal_game/normal_game_screen.dart';
import '../screens/normal_game_finished/normal_game_finished_screen.dart';
import '../screens/normal_game_setup/normal_game_setup_screen.dart';
import '../screens/normal_game_stats/normal_game_stats_screen.dart';
import '../screens/quick_game/quick_game_screen.dart';
import '../screens/quick_game_finished/quick_game_finished_screen.dart';
import '../screens/quick_game_stats/quick_game_stats_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/stats/stats_screen.dart';
import '../screens/time_game/time_game_screen.dart';
import '../screens/time_game_finished/time_game_finished_screen.dart';
import '../screens/time_game_setup/time_game_setup_screen.dart';
import '../screens/time_game_stats/time_game_stats_screen.dart';
import 'fade_page_route.dart';

///
/// ROUTES
///

Route onGenerateRoute(RouteSettings settings) {
  final route = switch (settings.name) {
    ModerniAliasRoutes.homeScreen => HomeScreen(),
    ModerniAliasRoutes.settingsScreen => SettingsScreen(),
    ModerniAliasRoutes.generalInfoScreen => GeneralInfoScreen(),
    ModerniAliasRoutes.howToPlayScreen => HowToPlayScreen(),
    ModerniAliasRoutes.normalGameSetupScreen => NormalGameSetupScreen(),
    ModerniAliasRoutes.normalGameScreen => NormalGameScreen(),
    ModerniAliasRoutes.normalGameFinishedScreen => NormalGameFinishedScreen(),
    ModerniAliasRoutes.quickGameScreen => QuickGameScreen(),
    ModerniAliasRoutes.quickGameFinishedScreen => QuickGameFinishedScreen(),
    ModerniAliasRoutes.timeGameSetupScreen => TimeGameSetupScreen(),
    ModerniAliasRoutes.timeGameScreen => TimeGameScreen(),
    ModerniAliasRoutes.timeGameFinishedScreen => TimeGameFinishedScreen(),
    ModerniAliasRoutes.statsScreen => StatsScreen(),
    ModerniAliasRoutes.normalGameStatsScreen => NormalGameStatsScreen(),
    ModerniAliasRoutes.timeGameStatsScreen => TimeGameStatsScreen(),
    ModerniAliasRoutes.quickGameStatsScreen => QuickGameStatsScreen(),
    _ => HomeScreen(),
  };

  return FadePageRoute(
    builder: (context) => route,
  );
}

///
/// ROUTE NAMES
///

class ModerniAliasRoutes {
  static const homeScreen = '/home';
  static const settingsScreen = '/settings';
  static const generalInfoScreen = '/general_info';
  static const howToPlayScreen = '/how_to_play';
  static const normalGameSetupScreen = '/normal_game_setup';
  static const normalGameScreen = '/normal_game';
  static const normalGameFinishedScreen = '/normal_game_finished';
  static const quickGameScreen = '/quick_game';
  static const quickGameFinishedScreen = '/quick_game_finished';
  static const timeGameSetupScreen = '/time_game_setup';
  static const timeGameScreen = '/time_game';
  static const timeGameFinishedScreen = '/time_game_finished';
  static const statsScreen = '/stats';
  static const normalGameStatsScreen = '/normal_game_stats';
  static const timeGameStatsScreen = '/time_game_stats';
  static const quickGameStatsScreen = '/quick_game_stats';
}

///
/// NAVIGATION
///

void goToHomeScreen(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil(
      ModerniAliasRoutes.homeScreen,
      (_) => false,
    );

void goToSettingsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.settingsScreen,
    );

void goToGeneralInfoScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.generalInfoScreen,
    );

void goToHowToPlayScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.howToPlayScreen,
    );

void goToNormalGameSetupScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.normalGameSetupScreen,
    );

void goToNormalGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.normalGameScreen,
    );

void goToNormalGameFinishedScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.normalGameFinishedScreen,
    );

void goToQuickGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.quickGameScreen,
    );

void goToQuickGameFinishedScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.quickGameFinishedScreen,
    );

void goToTimeGameSetupScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.timeGameSetupScreen,
    );

void goToTimeGameScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.timeGameScreen,
    );

void goToTimeGameFinishedScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.timeGameFinishedScreen,
    );

void goToStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.statsScreen,
    );

void goToNormalGameStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.normalGameStatsScreen,
    );

void goToTimeGameStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.timeGameStatsScreen,
    );

void goToQuickGameStatsScreen(BuildContext context) => Navigator.of(context).pushNamed(
      ModerniAliasRoutes.quickGameStatsScreen,
    );
