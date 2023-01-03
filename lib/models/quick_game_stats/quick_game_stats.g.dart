// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_game_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuickGameStatsAdapter extends TypeAdapter<QuickGameStats> {
  @override
  final int typeId = 2;

  @override
  QuickGameStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuickGameStats(
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
      round: fields[3] as Round,
      language: fields[4] as Flag,
    );
  }

  @override
  void write(BinaryWriter writer, QuickGameStats obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.round)
      ..writeByte(4)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickGameStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
