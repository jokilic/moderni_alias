import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/enums.dart';
import '../../models/team/team.dart';
import '../../services/dictionary_service.dart';
import '../../util/providers.dart';

final gameSetupProvider = Provider.autoDispose<GameSetupService>(
  GameSetupService.new,
  name: 'GameSetupProvider',
);

class GameSetupService {
  final Ref ref;

  GameSetupService(this.ref);

  ///
  /// METHODS
  ///

  /// Called when the user taps on the flag in [NormalGameSetupScreen]
  void updateDictionary(Flag chosenFlag) {
    ref.read(chosenDictionaryProvider.notifier).state = chosenFlag;
    ref.read(dictionaryProvider.notifier).refillCurrentDictionary();
  }

  /// Called when the user taps on the number of teams in [NormalGameSetupScreen]
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
    passedTeam.textEditingController.selection = TextSelection.collapsed(offset: passedTeam.textEditingController.text.length);
  }
}
