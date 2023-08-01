import 'package:hive/hive.dart';

part 'enums.g.dart';

enum Game {
  tapToStart,
  normal,
  quick,
  time,
  starting,
  end,
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
