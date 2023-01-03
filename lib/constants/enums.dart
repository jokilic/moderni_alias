import 'package:hive/hive.dart';

part 'enums.g.dart';

enum Game {
  none,
  normal,
  quick,
  starting,
}

enum Answer {
  correct,
  wrong,
}

@HiveType(typeId: 6)
enum Flag {
  @HiveField(0)
  croatia,

  @HiveField(1)
  unitedKingdom,
}
