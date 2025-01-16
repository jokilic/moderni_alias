import 'package:flutter/material.dart';

import '../../models/team/team.dart';
import '../../services/logger_service.dart';
import '../../util/typedef.dart';

class TimeGameSetupController extends ValueNotifier<TimeGameSetupState> {
  final LoggerService logger;

  TimeGameSetupController({
    required this.logger,
  }) : super(
          (
            teams: [
              for (var i = 0; i < 2; i++)
                Team(
                  name: '',
                  textEditingController: TextEditingController(),
                ),
            ],
            wordsToWin: 10,
            validationMessage: null,
          ),
        );

  ///
  /// METHODS
  ///

  /// Updates `state` with passed values
  void updateState({
    List<Team>? newTeams,
    int? newWordsToWin,
    String? newValidationMessage,
  }) =>
      value = (
        teams: newTeams ?? value.teams,
        wordsToWin: newWordsToWin ?? value.wordsToWin,
        validationMessage: newValidationMessage ?? value.validationMessage,
      );
}
