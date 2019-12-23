import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger_for_resistance/entity/player.dart';
import 'package:logger_for_resistance/entity/round.dart';

class Operations {

  static List<Player> getListFromBox(){
    List<Player> result = new List();
    Box<Player> playerBox = Hive.box('players');
    for(int i = 0; i < playerBox.length; i++){
      result.add(playerBox.getAt(i));
    }
    return result;
  }

  static Card drawPlayerCard(Player player) {
    return Card(
      color: player.getColor(),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          player.getName(),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  static List<Card> playersCards(Box<Player> box) {
    List<Card> result = new List();
    for (int i = 0; i < box.length; i++) {
      result.add(drawPlayerCard(box.getAt(i)));
    }
    return result;
  }


  static List<Player> listFromBox(Box<Player> box) {
    List<Player> result = new List();
    for (int i = 0; i < box.length; i++) {
      result.add(box.getAt(i));
    }
    return result;
  }

  static List<DataColumn> getColumnsFromBox(List<Round> roundList){
    List<DataColumn> result = new List();
    for(int i = 0; i < roundList[0].getPlayersCount(); i++){
      result.add(new DataColumn(label: Text(roundList[0].getPlayers()[i].getName())));
    }
    return result;
  }

  static DataRow drawCurrentRound(List<Round> roundBox, int index) {
    return DataRow(
      cells: drawRoundResult(roundBox[index]),
    );
  }

  static List<DataRow> roundRows(List<Round> roundList) {
    List<DataRow> result = new List();
    for (int i = 0; i < roundList.length; i++) {
      result.add(drawCurrentRound(roundList, i));
    }
    return result;
  }

  static List<Icon> fillRoundCell(Player player) {
    List<Icon> result = new List();
    if (player.getCommander()) result.add(Icon(Icons.verified_user));
    if (player.getTeam()) result.add(Icon(Icons.group));
    if (player.getVote()) {
      result.add(Icon(Icons.check));
    } else {
      result.add(Icon(Icons.clear));
    }
    return result;
  }

  static List<DataCell> drawRoundResult(Round round) {
    List<DataCell> result = new List();
    for (int i = 0; i < round.getPlayers().length; i++) {
      result.add(new DataCell(Card(
          color: resultColor(round.getRoundResult()),
          child: Row(
            children: fillRoundCell(round.getPlayers()[i]),
          ))));
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

  static List<Round> getRoundListFromBox(){
    Box<Round> box = Hive.box('rounds');
    List<Round> result = new List();
    for(int i = 0; i < box.length; i++){
      result.add(box.getAt(i));
    }
    return result;
  }
}
