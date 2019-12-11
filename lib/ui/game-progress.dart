import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resistance_log/app/player.dart';
import 'package:resistance_log/app/round.dart';

class GameProgress extends StatefulWidget {
  @override
  _GameProgressState createState() => _GameProgressState();
}

List<DataColumn> getNames(List<GameRound> rounds) {
  List<DataColumn> result = new List();
  for (int i = 0; i < rounds[0].players.length; i++) {
    result.add(new DataColumn(label: Text(rounds[0].players[i].getName())));
  }
  return result;
}

Color resultColor(OperationResult result) {
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

Card drawCard(Player player, OperationResult result) {
  return Card(
    color: resultColor(result),
    child: Row(
      children: <Widget>[
        if(player.isCommander) Icon(Icons.verified_user),
        if(player.inTeam) Icon(Icons.mood) else Icon(Icons.mood_bad),
        if(player.isVoted) Icon(Icons.check) else Icon(Icons.clear),
      ],
    ),
  );
}

List<DataCell> roundResult(GameRound round) {
  List<DataCell> result = new List();
  for (int i = 0; i < round.players.length; i++) {
    result.add(new DataCell(drawCard(round.players[i], round.result)));
  }
  return result;
}

DataRow currentRow(List<GameRound> rounds, int index){
  return DataRow(
    cells: roundResult(rounds[index]),
  );
}

List<DataRow> roundRow(List<GameRound> rounds){
  List<DataRow> result = new List();
  for(int i = 0; i < rounds.length; i++){
    result.add(currentRow(rounds, i));
  }
  return result;
}

List<GameRound> getList(){
  Box<GameRound> box = Hive.box('rounds');
  List<GameRound> result = new List();
  for(int i = 0; i < box.length; i++){
    result.add(box.getAt(i));
  }
  return result;
}

class _GameProgressState extends State<GameProgress> {
  
  @override
  Widget build(BuildContext context) {
    List<GameRound> rounds = getList();
    List<DataRow> rows = roundRow(rounds);
    return Scaffold(
      appBar: AppBar(
        title: Text("Rounds"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            setState(() {
              rows = roundRow(rounds);
            });
          },),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: getNames(rounds),
              rows: rows,
            )),
      ),
    );
  }
}
