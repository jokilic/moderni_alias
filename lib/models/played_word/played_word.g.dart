// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'played_word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayedWordAdapter extends TypeAdapter<PlayedWord> {
  @override
  final int typeId = 5;

  @override
  PlayedWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayedWord(
      word: fields[1] as String,
      chosenAnswer: fields[2] as Answer,
    );
  }

  @override
  void write(BinaryWriter writer, PlayedWord obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.chosenAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayedWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
