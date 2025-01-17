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
  final currentTeamIndex = teamsToCheck.indexWhere(
    (team) => team.name == playingTeam.name,
  );

  /// Ensure every team in the tie has had a chance to play
  return currentTeamIndex < teamsToCheck.length - 1;
}

Team getNextPlayingTeam({
  required List<Team> teams,
  required Team? previousTeam,
  int? overriddenIndex,
}) {
  /// If overriddenIndex is provided, use it (useful for starting tie break)
  if (overriddenIndex != null) {
    return teams[overriddenIndex];
  }

  /// If no previous team or teams list is empty, return first team
  if (previousTeam == null || teams.isEmpty) {
    return teams.first;
  }

  /// Try to find the previous team in the new list by comparing IDs or unique identifiers
  final currentIndex = teams.indexWhere(
    (team) => team.name == previousTeam.name,
  );

  /// If previous team isn't in the new list (tie break teams), start from beginning
  if (currentIndex == -1) {
    return teams.first;
  }

  /// If it was the last team, wrap around to first
  if (currentIndex == teams.length - 1) {
    return teams.first;
  }

  /// Otherwise return next team

  return teams[currentIndex + 1];
}
