import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/enums.dart';
import '../../models/team/team.dart';
import '../../services/dictionary_service.dart';

final teamsProvider = StateProvider.autoDispose<List<Team>>(
  (_) => [for (var i = 0; i < 2; i++) Team(name: '', textEditingController: TextEditingController())],
  name: 'TeamsProvider',
);
final teamsLengthProvider = StateProvider.autoDispose<int>(
  (ref) => ref.watch(teamsProvider).length,
  name: 'TeamsLengthProvider',
);
final pointsToWinProvider = StateProvider.autoDispose<int>(
  (_) => 50,
  name: 'PointsToWinProvider',
);
final lengthOfRoundProvider = StateProvider.autoDispose<int>(
  (_) => 60,
  name: 'LengthOfRoundProvider',
);
final validationMessageProvider = StateProvider.autoDispose<String?>(
  (_) => null,
  name: 'ValidationMessageProvider',
);

final startGameProvider = Provider.autoDispose<StartGameController>(
  StartGameController.new,
  name: 'StartGameProvider',
);

class StartGameController {
  final ProviderRef ref;

  StartGameController(this.ref);

  ///
  /// METHODS
  ///

  /// Called when the user taps on the flag in [StartGame]
  void updateDictionary(Flag chosenFlag) {
    ref.read(chosenDictionaryProvider.notifier).state = chosenFlag;
    ref.read(dictionaryProvider.notifier).refillCurrentDictionary();
  }

  /// Called when the user taps on the number of teams in [StartGame]
  void updateNumberOfTeams({required int chosenNumber}) {
    ref.read(teamsProvider.notifier).state
      ..clear()
      ..addAll([for (var i = 0; i < chosenNumber; i++) Team(name: '', textEditingController: TextEditingController())]);
    ref.read(teamsLengthProvider.notifier).state = chosenNumber;
  }

  /// Called when the user writes on the text field and adds a team name
  void teamNameUpdated({required Team passedTeam, required String value}) => ref.read(teamsProvider).firstWhere((team) => team == passedTeam).name = value;

  /// Checks if there are [Team] with the same `name` or with empty `name`
  bool validateTeams() {
    final teams = ref.read(teamsProvider);
    final nameSet = teams.map((team) => team.name).toSet();

    /// Found a team with an empty name
    if (teams.any((team) => team.name.isEmpty)) {
      ref.read(validationMessageProvider.notifier).state = 'teamNamesMissingString'.tr();
      return false;
    }

    /// Found teams with the same name
    if (nameSet.length != teams.length) {
      ref.read(validationMessageProvider.notifier).state = 'teamNamesSameString'.tr();
      return false;
    }

    /// No teams with the same name or empty names found
    ref.read(validationMessageProvider.notifier).state = null;
    return true;
  }

  /// Takes words from the dictionary and randomizes team names
  void randomizeTeamName({required Team passedTeam}) {
    final randomName = ref.read(dictionaryProvider.notifier).getRandomTeamName();

    teamNameUpdated(passedTeam: passedTeam, value: randomName);
    passedTeam.textEditingController.text = randomName;
  }
}
