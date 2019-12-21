import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:hive/hive.dart';
import 'package:logger_for_resistance/entity/player.dart';
import 'package:logger_for_resistance/entity/round.dart';

class Operations {

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

  static Container drawPlayerContainer(Player player, int index, int selected) {
    return Container(
      color: player.getColor(),
      padding: const EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Text(player.getName()),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.verified_user),
                  Radio(
                    value: index,
                    groupValue: selected,
                    onChanged: (value) {
                      if (index == selected) {
                        player.setCommander(true);
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.group),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Switch(
                      value: player.getTeam(),
                      onChanged: (value) {
                        player.setTeam(value);
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.check),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Switch(
                      value: player.getVote(),
                      onChanged: (value) {
                        player.setVote(value);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  static List<Container> playersContainer(Box<Player> players, int selected) {
    List<Container> result = new List();
    for (int i = 0; i < players.length; i++) {
      result.add(drawPlayerContainer(players.getAt(i), i, selected));
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

  static List<DataColumn> getColumnsFromBox(Box<Round> roundBox){
    List<DataColumn> result = new List();
    for(int i = 0; i < roundBox.getAt(0).getPlayersCount(); i++){
      result.add(new DataColumn(label: Text(roundBox.getAt(0).getPlayers()[i].getName())));
    }
    return result;
  }

  static DataRow drawCurrentRound(Box<Round> roundBox, int index) {
    return DataRow(
      cells: drawRoundResult(roundBox.getAt(index)),
    );
  }

  static List<DataRow> roundRows(Box<Round> roundBox) {
    List<DataRow> result = new List();
    for (int i = 0; i < roundBox.length; i++) {
      result.add(drawCurrentRound(roundBox, i));
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
}
