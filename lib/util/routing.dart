import 'package:flutter/material.dart';

import '../models/normal_game_stats/normal_game_stats.dart';
import '../models/played_word/played_word.dart';
import '../models/quick_game_stats/quick_game_stats.dart';
import '../models/round/round.dart';
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
import '../screens/settings_words/settings_words_screen.dart';
import '../screens/stats/stats_screen.dart';
import '../screens/stats_normal_game/stats_normal_game_screen.dart';
import '../screens/stats_quick_game/stats_quick_game_screen.dart';
import '../screens/stats_time_game/stats_time_game_screen.dart';
import '../screens/time_game/time_game_screen.dart';
import '../screens/time_game_finished/time_game_finished_screen.dart';
import '../screens/time_game_setup/time_game_setup_screen.dart';
import '../screens/words_list/words_list_screen.dart';
import 'navigation.dart';

void openHome(BuildContext context) => pushScreen(
  HomeScreen(),
  context: context,
  popEverything: true,
);

void openSettings(BuildContext context) => pushScreen(
  SettingsScreen(),
  context: context,
);

void openGeneralInfo(BuildContext context) => pushScreen(
  GeneralInfoScreen(),
  context: context,
);

void openHowToPlay(BuildContext context) => pushScreen(
  HowToPlayScreen(),
  context: context,
);

void openSettingsWords(BuildContext context) => pushScreen(
  SettingsWordsScreen(),
  context: context,
);

void openWordsList(
  BuildContext context, {
  required String title,
  required List<String> words,
}) => pushScreen(
  WordsListScreen(
    title: title,
    words: words,
  ),
  context: context,
);

void openNormalGameSetup(BuildContext context) => pushScreen(
  NormalGameSetupScreen(),
  context: context,
);

void openNormalGame(
  BuildContext context, {
  required List<Team> teams,
  required int pointsToWin,
  required int lengthOfRound,
}) => pushScreen(
  NormalGameScreen(
    teams: teams,
    pointsToWin: pointsToWin,
    lengthOfRound: lengthOfRound,
  ),
  context: context,
);

void openNormalGameFinished(
  BuildContext context, {
  required List<Team> teams,
  required int pointsToWin,
  required int lengthOfRound,
  required List<PlayedWord> playedWords,
}) => pushScreen(
  NormalGameFinishedScreen(
    teams: teams,
    pointsToWin: pointsToWin,
    lengthOfRound: lengthOfRound,
    playedWords: playedWords,
  ),
  context: context,
);

void openQuickGame(
  BuildContext context, {
  required int lengthOfRound,
}) => pushScreen(
  QuickGameScreen(
    lengthOfRound: lengthOfRound,
  ),
  context: context,
);

void openQuickGameFinished(
  BuildContext context, {
  required List<PlayedWord> playedWords,
}) => pushScreen(
  QuickGameFinishedScreen(
    playedWords: playedWords,
  ),
  context: context,
);

void openTimeGameSetup(BuildContext context) => pushScreen(
  TimeGameSetupScreen(),
  context: context,
);

void openTimeGame(
  BuildContext context, {
  required List<Team> teams,
  required int numberOfWords,
}) => pushScreen(
  TimeGameScreen(
    teams: teams,
    numberOfWords: numberOfWords,
  ),
  context: context,
);

void openTimeGameFinished(
  BuildContext context, {
  required List<Team> teams,
  required int numberOfWords,
  required List<Round> rounds,
  required List<PlayedWord> playedWords,
}) => pushScreen(
  TimeGameFinishedScreen(
    teams: teams,
    numberOfWords: numberOfWords,
    rounds: rounds,
    playedWords: playedWords,
  ),
  context: context,
);

void openStats(BuildContext context) => pushScreen(
  StatsScreen(),
  context: context,
);

void openStatsNormalGame(
  BuildContext context, {
  required NormalGameStats normalGameStats,
}) => pushScreen(
  StatsNormalGameScreen(
    normalGameStats: normalGameStats,
  ),
  context: context,
);

void openStatsTimeGame(
  BuildContext context, {
  required TimeGameStats timeGameStats,
}) => pushScreen(
  StatsTimeGameScreen(
    timeGameStats: timeGameStats,
  ),
  context: context,
);

void openStatsQuickGame(
  BuildContext context, {
  required QuickGameStats quickGameStats,
}) => pushScreen(
  StatsQuickGameScreen(
    quickGameStats: quickGameStats,
  ),
  context: context,
);
