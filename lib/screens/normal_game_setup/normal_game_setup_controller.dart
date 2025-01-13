import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/team/team.dart';
import '../../services/dictionary_service.dart';
import '../../services/logger_service.dart';
import '../../util/typedef.dart';

class NormalGameSetupController extends ValueNotifier<NormalGameSetupState> {
  final LoggerService logger;
  final DictionaryService dictionary;

  NormalGameSetupController({
    required this.logger,
    required this.dictionary,
  }) : super(
          (
            teams: [
              for (var i = 0; i < 2; i++)
                Team(
                  name: '',
                  textEditingController: TextEditingController(),
                ),
            ],
            pointsToWin: 50,
            lengthOfRound: 60,
            validationMessage: null,
          ),
        );

  ///
  /// METHODS
  ///

  /// Updates `state` with passed values
  void updateState({
    List<Team>? newTeams,
    int? newPointsToWin,
    int? newLengthOfRound,
    String? newValidationMessage,
  }) =>
      value = (
        teams: newTeams ?? value.teams,
        pointsToWin: newPointsToWin ?? value.pointsToWin,
        lengthOfRound: newLengthOfRound ?? value.lengthOfRound,
        validationMessage: (newValidationMessage?.isEmpty ?? false) ? null : newValidationMessage ?? value.validationMessage,
      );

  /// Called when the user writes on the text field and updates team name
  void teamNameUpdated({required Team passedTeam, required String newName}) {
    final newTeams = value.teams
        .map(
          (team) => team == passedTeam ? team.copyWith(name: newName) : team,
        )
        .toList();

    updateState(newTeams: newTeams);
  }

  /// Takes words from the dictionary and randomizes team names
  void randomizeTeamName({required Team passedTeam}) {
    final randomName = dictionary.getRandomTeamName();

    teamNameUpdated(
      passedTeam: passedTeam,
      newName: randomName,
    );

    passedTeam.textEditingController.text = randomName;
    passedTeam.textEditingController.selection = TextSelection.collapsed(
      offset: passedTeam.textEditingController.text.length,
    );
  }

  /// Checks if there are [Team] with the same `name` or with empty `name`
  bool validateTeams() {
    final nameSet = value.teams.map((team) => team.name).toSet();

    /// Found a [Team] with an empty `name`
    if (value.teams.any((team) => team.name.isEmpty)) {
      updateState(newValidationMessage: 'teamNamesMissingString'.tr());
      return false;
    }

    /// Found [Teams] with the same `name`
    if (nameSet.length != value.teams.length) {
      updateState(newValidationMessage: 'teamNamesSameString'.tr());
      return false;
    }

    /// No [Teams] with the same `name` or empty `names` found
    updateState(newValidationMessage: '');
    return true;
  }
}
