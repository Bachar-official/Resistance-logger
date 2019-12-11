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

  Player();

  Player.withName(String name){
    this.name = name;
    isCommander = false;
    inTeam = false;
    isVoted = false;
  }

  String getName(){
    return this.name;
  }

  void setRound(bool commander, bool team, bool vote){
    isCommander = commander;
    inTeam = team;
    isVoted = vote;
  }
}