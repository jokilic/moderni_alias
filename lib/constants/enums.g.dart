// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerAdapter extends TypeAdapter<Answer> {
  @override
  final int typeId = 7;

  @override
  Answer read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Answer.correct;
      case 1:
        return Answer.wrong;
      default:
        return Answer.correct;
    }
  }

  @override
  void write(BinaryWriter writer, Answer obj) {
    switch (obj) {
      case Answer.correct:
        writer.writeByte(0);
        break;
      case Answer.wrong:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FlagAdapter extends TypeAdapter<Flag> {
  @override
  final int typeId = 6;

  @override
  Flag read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Flag.croatia;
      case 1:
        return Flag.unitedKingdom;
      default:
        return Flag.croatia;
    }
  }

  @override
  void write(BinaryWriter writer, Flag obj) {
    switch (obj) {
      case Flag.croatia:
        writer.writeByte(0);
        break;
      case Flag.unitedKingdom:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
