import '../constants/enums.dart';
import '../models/team/team.dart';

typedef DictionaryState = ({
  String currentWord,
  Flag chosenLanguage,
});

typedef NormalGameSetupState = ({
  List<Team> teams,
  int pointsToWin,
  int lengthOfRound,
  String? validationMessage,
});

typedef TimeGameSetupState = ({
  List<Team> teams,
  int wordsToWin,
  String? validationMessage,
});
