import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/enums.dart';
import '../../models/team/team.dart';
import '../../services/dictionary_service.dart';

final teamsProvider = StateProvider<List<Team>>(
  (_) => [for (var i = 0; i < 2; i++) Team(name: '')],
);
final pointsToWinProvider = StateProvider<int>((_) => 50);
final lengthOfRoundProvider = StateProvider<int>((_) => 60);
final validationMessageProvider = StateProvider<String?>((_) => null);

final startGameProvider = Provider<StartGameController>(StartGameController.new);

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
  void updateNumberOfTeams({required int chosenNumber}) => ref.read(teamsProvider.notifier).state
    ..clear()
    ..addAll([for (var i = 0; i < chosenNumber; i++) Team(name: '')]);

  /// Called when the user writes on the text field and adds a team name
  void teamNameUpdated({required Team passedTeam, required String value}) => ref.read(teamsProvider.notifier).state.firstWhere((team) => team == passedTeam).name = value;

  /// Called when the user taps the 'Play' button
  bool validateMainGame() {
    /// Check if any of team names are same
    final duplicateTeamsList = <Team>[];
    ref.read(teamsProvider.notifier).state.map((team) {
      if (duplicateTeamsList.contains(team)) {
        ref.read(validationMessageProvider.notifier).state = 'teamNamesSameString'.tr();
        return false;
      } else {
        duplicateTeamsList.add(team);
      }
    }).toList();

    /// Check if any of the teams has an empty name
    ref.read(teamsProvider.notifier).state.map((team) {
      if (team.name.isEmpty) {
        ref.read(validationMessageProvider.notifier).state = 'teamNamesMissingString'.tr();
        return false;
      }
    }).toList();

    /// Validation passed successfully
    ref.read(validationMessageProvider.notifier).state = null;
    return true;
  }
}