// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoundAdapter extends TypeAdapter<Round> {
  @override
  final int typeId = 4;

  @override
  Round read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Round(
      playedWords: (fields[1] as List).cast<PlayedWord>(),
      playingTeam: fields[2] as Team?,
    );
  }

  @override
  void write(BinaryWriter writer, Round obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.playedWords)
      ..writeByte(2)
      ..write(obj.playingTeam);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}