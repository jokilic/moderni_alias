import 'package:flutter/material.dart';

import '../../models/team/team.dart';
import '../../services/logger_service.dart';
import '../../util/typedef.dart';

class NormalGameSetupController extends ValueNotifier<NormalGameSetupState> {
  final LoggerService logger;

  NormalGameSetupController({
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
        validationMessage: newValidationMessage ?? value.validationMessage,
      );
}
