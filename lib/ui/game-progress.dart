import 'package:flutter/material.dart';
import 'package:resistance_log/app/operations.dart';
import 'package:resistance_log/app/round.dart';
import 'package:resistance_log/app_localizations.dart';

class GameProgress extends StatefulWidget {
  @override
  _GameProgressState createState() => _GameProgressState();
}

class _GameProgressState extends State<GameProgress> {
  @override
  Widget build(BuildContext context) {
    List<GameRound> rounds = Operations.getList();
    if (rounds.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('no_rounds')),
        ),
      );
    } else {
      List<DataRow> dataRows = Operations.roundRow(rounds);
      return Scaffold(
        appBar: AppBar(
          title: Text("Rounds"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: Operations.getNamesFromRounds(rounds),
                rows: dataRows,
              )),
        ),
      );
    }
  }
}
