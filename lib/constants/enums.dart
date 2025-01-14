import 'package:hive_ce/hive.dart';

part 'enums.g.dart';

enum GameState {
  idle,
  starting,
  playing,
  finished,
}

@HiveType(typeId: 7)
enum Answer {
  @HiveField(0)
  correct,

  @HiveField(1)
  wrong,
}

@HiveType(typeId: 6)
enum Flag {
  @HiveField(0)
  croatia,

  @HiveField(1)
  unitedKingdom,
}
