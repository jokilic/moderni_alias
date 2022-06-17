// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStatsAdapter extends TypeAdapter<GameStats> {
  @override
  final int typeId = 0;

  @override
  GameStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameStats(
      playedQuickGames: fields[1] as int,
      playedNormalGames: fields[2] as int,
      correctAnswersQuickGames: fields[3] as int,
      wrongAnswersQuickGames: fields[4] as int,
      correctAnswersNormalGames: fields[5] as int,
      wrongAnswersNormalGames: fields[6] as int,
      playedNormalGameRounds: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GameStats obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.playedQuickGames)
      ..writeByte(2)
      ..write(obj.playedNormalGames)
      ..writeByte(3)
      ..write(obj.correctAnswersQuickGames)
      ..writeByte(4)
      ..write(obj.wrongAnswersQuickGames)
      ..writeByte(5)
      ..write(obj.correctAnswersNormalGames)
      ..writeByte(6)
      ..write(obj.wrongAnswersNormalGames)
      ..writeByte(7)
      ..write(obj.playedNormalGameRounds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
