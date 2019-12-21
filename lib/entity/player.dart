import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'player.g.dart';

@HiveType()
class Player{

  @HiveField(0)
  String _name;

  @HiveField(1)
  bool _isCommander;

  @HiveField(2)
  bool _isInTeam;

  @HiveField(3)
  bool _isVoted;

  @HiveField(4)
  String _color;

  Player();

  Player.withNameAndColor(String name, Color color){
    _name = name;
    _isCommander = false;
    _isInTeam = false;
    _isVoted = false;
    _color = color.toString();
  }

  Color getColor(){
    String valueString = _color.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  setColor(Color color){
    _color = color.toString();
  }

  bool getVote(){
    return _isVoted;
  }

  setVote(bool value) {
    _isVoted = value;
  }

  bool getTeam(){
    return _isInTeam;
  }

  setTeam(bool team) {
    _isInTeam = team;
  }

  bool getCommander(){
    return _isCommander;
  }

  setCommander(bool commander) {
    _isCommander = commander;
  }

  String getName(){
    return _name;
  }

  setName(String name) {
    _name = name;
  }


}