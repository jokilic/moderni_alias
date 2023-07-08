// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_game_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeGameStatsAdapter extends TypeAdapter<TimeGameStats> {
  @override
  final int typeId = 8;

  @override
  TimeGameStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeGameStats(
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
      teams: (fields[3] as List).cast<Team>(),
      rounds: (fields[4] as List).cast<Round>(),
      language: fields[5] as Flag,
    );
  }

  @override
  void write(BinaryWriter writer, TimeGameStats obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.teams)
      ..writeByte(4)
      ..write(obj.rounds)
      ..writeByte(5)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeGameStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
