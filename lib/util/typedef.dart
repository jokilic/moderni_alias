import '../constants/enums.dart';
import '../models/played_word/played_word.dart';
import '../models/team/team.dart';

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

typedef QuickGameState = ({
  int correctWords,
  int wrongWords,
  GameState gameState,
  int counter3Seconds,
  List<PlayedWord> playedWords,
  String? currentWord,
});
