import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/normal_game_stats/normal_game_stats.dart';
import '../models/quick_game_stats/quick_game_stats.dart';
import '../models/team/team.dart';
import '../models/time_game_stats/time_game_stats.dart';
import '../screens/general_info/general_info_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/how_to_play/how_to_play_screen.dart';
import '../screens/normal_game/normal_game_screen.dart';
import '../screens/normal_game_finished/normal_game_finished_screen.dart';
import '../screens/normal_game_setup/normal_game_setup_screen.dart';
import '../screens/quick_game/quick_game_screen.dart';
import '../screens/quick_game_finished/quick_game_finished_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/stats/stats_screen.dart';
import '../screens/stats_normal_game/stats_normal_game_screen.dart';
import '../screens/stats_quick_game/stats_quick_game_screen.dart';
import '../screens/stats_time_game/stats_time_game_screen.dart';
import '../screens/time_game/time_game_screen.dart';
import '../screens/time_game_finished/time_game_finished_screen.dart';
import '../screens/time_game_setup/time_game_setup_screen.dart';
import 'navigation.dart';

void openHome(BuildContext context) => pushScreen(
      const HomeScreen(
        key: ValueKey('home'),
      ),
      context: context,
      popEverything: true,
    );

void openSettings(BuildContext context) => pushScreen(
      const SettingsScreen(
        key: ValueKey('settings'),
      ),
      context: context,
    );

void openGeneralInfo(BuildContext context) => pushScreen(
      const GeneralInfoScreen(
        key: ValueKey('general-info'),
      ),
      context: context,
    );

void openHowToPlay(BuildContext context) => pushScreen(
      const HowToPlayScreen(
        key: ValueKey('how-to-play'),
      ),
      context: context,
    );

void openNormalGameSetup(BuildContext context) => pushScreen(
      const NormalGameSetupScreen(
        key: ValueKey('normal-game-setup'),
      ),
      context: context,
    );

void openNormalGame(
  BuildContext context, {
  required List<Team> teams,
}) =>
    pushScreen(
      NormalGameScreen(
        key: ValueKey(teams),
      ),
      context: context,
    );

void openNormalGameFinished(
  BuildContext context, {
  required List<Team> teams,
}) =>
    pushScreen(
      NormalGameFinishedScreen(
        teams: teams,
        key: ValueKey(teams),
      ),
      context: context,
    );

void openQuickGame(BuildContext context) => pushScreen(
      const QuickGameScreen(
        key: ValueKey('quick-game'),
      ),
      context: context,
    );

void openQuickGameFinished(BuildContext context) => pushScreen(
      const QuickGameFinishedScreen(
        key: ValueKey('quick-game-finished'),
      ),
      context: context,
    );

void openTimeGameSetup(BuildContext context) => pushScreen(
      const TimeGameSetupScreen(
        key: ValueKey('time-game-setup'),
      ),
      context: context,
    );

void openTimeGame(
  BuildContext context, {
  required List<Team> teams,
}) =>
    pushScreen(
      TimeGameScreen(
        key: ValueKey(teams),
      ),
      context: context,
    );

void openTimeGameFinished(
  BuildContext context, {
  required List<Team> teams,
}) =>
    pushScreen(
      TimeGameFinishedScreen(
        key: ValueKey(teams),
      ),
      context: context,
    );

void openStats(BuildContext context) => pushScreen(
      const StatsScreen(
        key: ValueKey('stats'),
      ),
      context: context,
    );

void openStatsNormalGame(
  BuildContext context, {
  required NormalGameStats normalGameStats,
}) =>
    pushScreen(
      StatsNormalGameScreen(
        normalGameStats: normalGameStats,
        key: ValueKey(normalGameStats),
      ),
      context: context,
    );

void openStatsTimeGame(
  BuildContext context, {
  required TimeGameStats timeGameStats,
}) =>
    pushScreen(
      StatsTimeGameScreen(
        timeGameStats: timeGameStats,
        key: ValueKey(timeGameStats),
      ),
      context: context,
    );

void openStatsQuickGame(
  BuildContext context, {
  required QuickGameStats quickGameStats,
}) =>
    pushScreen(
      StatsQuickGameScreen(
        quickGameStats: quickGameStats,
        key: ValueKey(quickGameStats),
      ),
      context: context,
    );
