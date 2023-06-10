import '../../constants/enums.dart';
import '../team/team.dart';

class NormalGameArguments {
  final Flag chosenDictionary;
  final List<Team> teams;
  final int pointsToWin;
  final int lengthOfRound;

  NormalGameArguments({
    required this.chosenDictionary,
    required this.teams,
    required this.pointsToWin,
    required this.lengthOfRound,
  });
}
