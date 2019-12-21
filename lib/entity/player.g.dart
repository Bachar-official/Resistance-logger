// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  Player read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player()
      .._name = fields[0] as String
      .._isCommander = fields[1] as bool
      .._isInTeam = fields[2] as bool
      .._isVoted = fields[3] as bool
      .._color = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._isCommander)
      ..writeByte(2)
      ..write(obj._isInTeam)
      ..writeByte(3)
      ..write(obj._isVoted)
      ..writeByte(4)
      ..write(obj._color);
  }
}
