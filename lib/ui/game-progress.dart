import 'package:flutter/material.dart';

class GameProgress extends StatefulWidget {
  @override
  _GameProgressState createState() => _GameProgressState();
}

class _GameProgressState extends State<GameProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [],
              rows: [],
            )),
      ),
    );
  }
}
