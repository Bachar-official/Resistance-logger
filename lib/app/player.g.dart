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
      ..name = fields[0] as String
      ..isCommander = fields[1] as bool
      ..inTeam = fields[2] as bool
      ..isVoted = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isCommander)
      ..writeByte(2)
      ..write(obj.inTeam)
      ..writeByte(4)
      ..write(obj.isVoted);
  }
}
