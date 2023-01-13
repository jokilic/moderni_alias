import 'package:hive/hive.dart';

part 'enums.g.dart';

enum Game {
  none,
  normal,
  quick,
  starting,
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
