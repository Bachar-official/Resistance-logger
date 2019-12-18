import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resistance_log/app/player.dart';
import 'package:resistance_log/app/round.dart';

class Operations {
  static List<String> getNames(Box<String> box) {
    List<String> result = new List();
    for (int i = 0; i < box.length; i++) {
      result.add(box.getAt(i));
    }
    return result;
  }

  static GameRound newRound(List<Player> players, OperationResult result) {
    return new GameRound.withList(players, result);
  }

  static List<Player> setPlayersList(List<String> list) {
    List<Player> result = new List();
    for (int i = 0; i < list.length; i++) {
      result.add(new Player.withName(list[i]));
    }
    return result;
  }

  static List<GameRound> getList() {
    Box<GameRound> box = Hive.box('rounds');
    List<GameRound> result = new List();
    for (int i = 0; i < box.length; i++) {
      result.add(box.getAt(i));
    }
    return result;
  }

  static List<DataRow> roundRow(List<GameRound> rounds) {
    List<DataRow> result = new List();
    for (int i = 0; i < rounds.length; i++) {
      result.add(currentRow(rounds, i));
    }

    return result;
  }

  static DataRow currentRow(List<GameRound> rounds, int index) {
    return DataRow(
      cells: roundResult(rounds[index]),
    );
  }

  static List<DataColumn> getNamesFromRounds(List<GameRound> rounds) {
    List<DataColumn> result = new List();
    for (int i = 0; i < rounds[0].players.length; i++) {
      result.add(new DataColumn(label: Text(rounds[0].players[i].getName())));
    }
    return result;
  }

  static Color resultColor(OperationResult result) {
    switch (result) {
      case OperationResult.SUCCESS:
        return Colors.blue;
      case OperationResult.FAIL:
        return Colors.red;
      case OperationResult.NO_VOTE:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  static Card drawCard(Player player, OperationResult result) {
    return Card(
      color: resultColor(result),
      child: Row(
        children: <Widget>[
          if (player.getCommander()) Icon(Icons.verified_user),
          if (player.getTeam()) Icon(Icons.mood),
          if (player.getVote()) Icon(Icons.check) else Icon(Icons.clear),
        ],
      ),
    );
  }

  static List<DataCell> roundResult(GameRound round) {
    List<DataCell> result = new List();
    for (int i = 0; i < round.players.length; i++) {
      result.add(new DataCell(Card(
        color: resultColor(round.result),
        child: Row(
          children: <Widget>[
            if (round.getPlayerCommaner(i)) Icon(Icons.verified_user),
            if (round.getPlayerTeam(i))
              Icon(Icons.group),
            if (round.getPlayerVote(i))
              Icon(Icons.check)
            else
              Icon(Icons.clear),
          ],
        ),
      )));
    }
    return result;
  }
}
