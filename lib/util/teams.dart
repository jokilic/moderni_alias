import 'dart:math';

import '../models/team/team.dart';

/// Returns a list of `Teams` who have enough points to win the game
List<Team> getTeamsWithEnoughPoints({
  required List<Team> teams,
  required int pointsToWin,
}) =>
    teams.where((team) => team.points >= pointsToWin).toList();

/// Find all teams that are tied for first place
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

  /// Ensure every team in the tie has had a chance to play
  return currentTeamIndex < teamsToCheck.length - 1;
}
