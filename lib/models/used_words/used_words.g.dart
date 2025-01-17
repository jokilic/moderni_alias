// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used_words.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsedWordsAdapter extends TypeAdapter<UsedWords> {
  @override
  final int typeId = 10;

  @override
  UsedWords read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsedWords(
      croatianWords: (fields[0] as List).cast<String>(),
      englishWords: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UsedWords obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.croatianWords)
      ..writeByte(1)
      ..write(obj.englishWords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsedWordsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
