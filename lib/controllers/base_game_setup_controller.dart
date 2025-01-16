import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/team/team.dart';
import '../services/dictionary_service.dart';
import '../services/logger_service.dart';

class BaseGameSetupController {
  final LoggerService logger;
  final DictionaryService dictionary;

  BaseGameSetupController({
    required this.logger,
    required this.dictionary,
  });

  ///
  /// METHODS
  ///

  /// Called when the user writes on the text field and updates team name
  void onChangedTeamName({
    required Team passedTeam,
    required String newName,
  }) =>
      passedTeam.name = newName;

  /// Takes words from the dictionary and randomizes team name
  void randomizeTeamName({required Team passedTeam}) {
    /// Generate `randomName`
    final randomName = dictionary.getRandomTeamName();

    /// Update name on `passedTeam`
    onChangedTeamName(
      passedTeam: passedTeam,
      newName: randomName,
    );

    /// Update [TextEditingController] on `passedTeam` and move cursor to end
    passedTeam.textEditingController.text = randomName;
    passedTeam.textEditingController.selection = TextSelection.collapsed(
      offset: passedTeam.textEditingController.text.length,
    );
  }

  /// Checks if there are [Team] with the same `name` or with empty `name`
  /// Returns an error [String] or `null`
  String? validateTeams({required List<Team> teams}) {
    final nameSet = teams.map((team) => team.name).toSet();

    /// Found a [Team] with an empty `name`
    if (teams.any((team) => team.name.isEmpty)) {
      return 'teamNamesMissingString'.tr();
    }

    /// Found [Teams] with the same `name`
    if (nameSet.length != teams.length) {
      return 'teamNamesSameString'.tr();
    }

    /// No [Teams] with the same `name` or empty `names` found
    return null;
  }
}
