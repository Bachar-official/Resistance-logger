import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger_for_resistance/app/operations.dart';
import 'package:logger_for_resistance/entity/round.dart';

class GameProgressPage extends StatefulWidget{
  @override
  _GameProgressState createState() => _GameProgressState();
}

class _GameProgressState extends State<GameProgressPage>{
  List<Round> roundList = Operations.getRoundListFromBox();

  @override
  Widget build(BuildContext context){
    if(roundList.length == 0){
      return Scaffold(
        appBar: AppBar(
          title: Text('There is no rounds yet!'),
        ),
      );
    }
    else{
      return Scaffold(
        appBar: AppBar(
          title: Text('Game progress'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: Operations.getColumnsFromBox(roundList),
                rows: Operations.roundRows(roundList),
              ),
          ),
        )
      );
    }

  }
}