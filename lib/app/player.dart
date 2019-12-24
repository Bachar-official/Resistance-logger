import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType()
class Player extends HiveObject{

  @HiveField(0)
  String name;

  @HiveField(1)
  bool isCommander;

  @HiveField(2)
  bool inTeam;

  @HiveField(4)
  bool isVoted;

  @HiveField(5)
  String color;

  Player();

  Player.withNameAndColor(String name, Color color){
    this.name = name;
    isCommander = false;
    inTeam = false;
    isVoted = false;
    this.color = color.toString();
  }

  Color getColor(){
    String valueString = this.color.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  String getName(){
    return this.name;
  }

  void setCommander(bool comm){
    this.isCommander = comm;
  }

  void setTeam(bool team){
    this.inTeam = team;
  }

  void setVote(bool vote){
    this.isVoted = vote;
  }

  bool getCommander(){
    return this.isCommander;
  }

  bool getTeam(){
    return this.inTeam;
  }

  bool getVote(){
    return this.isVoted;
  }
}