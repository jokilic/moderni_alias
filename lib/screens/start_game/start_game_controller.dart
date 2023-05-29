import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/enums.dart';
import '../../models/team/team.dart';
import '../../services/dictionary_service.dart';

final teamsProvider = StateProvider<List<Team>>(
  (_) => [for (var i = 0; i < 2; i++) Team(name: '')],
);
final pointsToWinProvider = StateProvider<int>((_) => 50);
final lengthOfRoundProvider = StateProvider<int>((_) => 60);
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
}
