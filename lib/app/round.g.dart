// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationResultAdapter extends TypeAdapter<OperationResult> {
  @override
  OperationResult read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OperationResult.SUCCESS;
      case 1:
        return OperationResult.FAIL;
      case 2:
        return OperationResult.NO_VOTE;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, OperationResult obj) {
    switch (obj) {
      case OperationResult.SUCCESS:
        writer.writeByte(0);
        break;
      case OperationResult.FAIL:
        writer.writeByte(1);
        break;
      case OperationResult.NO_VOTE:
        writer.writeByte(2);
        break;
    }
  }
}

class GameRoundAdapter extends TypeAdapter<GameRound> {
  @override
  GameRound read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameRound()
      ..players = (fields[0] as List)?.cast<Player>()
      ..result = fields[1] as OperationResult;
  }

  @override
  void write(BinaryWriter writer, GameRound obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.players)
      ..writeByte(1)
      ..write(obj.result);
  }
}
