// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_game_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NormalGameStatsAdapter extends TypeAdapter<NormalGameStats> {
  @override
  final int typeId = 1;

  @override
  NormalGameStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NormalGameStats(
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
      teams: (fields[3] as List).cast<Team>(),
      rounds: (fields[4] as List).cast<Round>(),
      lengthOfRound: fields[5] as int,
      pointsToWin: fields[6] as int,
      language: fields[7] as Flag,
    );
  }

  @override
  void write(BinaryWriter writer, NormalGameStats obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.teams)
      ..writeByte(4)
      ..write(obj.rounds)
      ..writeByte(5)
      ..write(obj.lengthOfRound)
      ..writeByte(6)
      ..write(obj.pointsToWin)
      ..writeByte(7)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NormalGameStatsAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
