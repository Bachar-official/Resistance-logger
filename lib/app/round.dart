import 'package:resistance_log/app/player.dart';
import 'package:hive/hive.dart';

part 'round.g.dart';

@HiveType()
enum OperationResult{

  @HiveField(0)
  SUCCESS,

  @HiveField(1) 
  FAIL, 

  @HiveField(2)
  NO_VOTE,
}

@HiveType()
class GameRound extends HiveObject{

  @HiveField(0)
  List<Player> players;

  @HiveField(1)
  OperationResult result;

  GameRound();

  GameRound.withList(List<Player> players, OperationResult result){
    this.players = players;
    this.result = result;
  }
}