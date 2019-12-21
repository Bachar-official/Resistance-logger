import 'package:hive/hive.dart';
import 'package:logger_for_resistance/entity/player.dart';
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
class Round{

  @HiveField(0)
  List<Player> _players;

  @HiveField(1)
  OperationResult _result;

  Round();

  Round.advanced(List<Player> players, OperationResult result){
    _players = players;
    _result = result;
  }

  List<Player> getPlayers(){
    return _players;
  }

  int getPlayersCount(){
    return _players.length;
  }

  OperationResult getRoundResult(){
    return _result;
  }
}