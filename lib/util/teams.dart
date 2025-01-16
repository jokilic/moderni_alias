import 'dart:math';

import '../models/team/team.dart';

/// Returns a list of `Teams` who have enough points to win the game
List<Team> getTeamsWithEnoughPoints({
  required List<Team> teams,
  required int pointsToWin,
}) =>
    teams.where((team) => team.points >= pointsToWin).toList();

// Find all teams that are tied for first place
List<Team> getTiedTeams(List<Team> teamsWithEnoughPoints) {
  final maxPoints = teamsWithEnoughPoints.map((team) => team.points).reduce(max);
  return teamsWithEnoughPoints.where((team) => team.points == maxPoints).toList();
}

/// Checks if current round is finished
bool roundNotDone({
  required List<Team> teamsToCheck,
  required Team playingTeam,
}) {
  final currentTeamIndex = teamsToCheck.indexOf(playingTeam);

  /// Find the maximum points among the teams with enough points
  final maxPoints = teamsToCheck.map((team) => team.points).reduce(max);

  /// Check if the current team has reached the maximum points but is not the last team to play
  return playingTeam.points <= maxPoints && currentTeamIndex < teamsToCheck.length - 1;
}
