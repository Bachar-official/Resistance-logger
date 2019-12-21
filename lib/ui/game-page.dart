import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger_for_resistance/app/routing.dart';
import 'package:logger_for_resistance/entity/player.dart';
import 'package:logger_for_resistance/entity/round.dart';
import 'package:logger_for_resistance/app/operations.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Box<Player> playersBox = Hive.box('players');
  Box<Round> roundsBox = Hive.box('rounds');
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current round: ' + (roundsBox.length + 1).toString()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check_circle),
            color: Colors.blue,
            onPressed: () {
              roundsBox.add(Round.advanced(
                  Operations.listFromBox(playersBox), OperationResult.SUCCESS));
            },
          ),
          IconButton(
            icon: Icon(Icons.cancel),
            color: Colors.red,
            onPressed: () {
              roundsBox.add(Round.advanced(
                  Operations.listFromBox(playersBox), OperationResult.FAIL));
            },
          ),
          IconButton(
            icon: Icon(Icons.cached),
            color: Colors.grey,
            onPressed: () {
              roundsBox.add(Round.advanced(
                  Operations.listFromBox(playersBox), OperationResult.NO_VOTE));
            },
          ),
          IconButton(
            icon: Icon(Icons.screen_share),
            onPressed: () {
              Navigator.pushNamed(context, Router.progressPage);
            },
          )
        ],
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: Operations.playersContainer(playersBox, selected),
      ),
    );
  }
}
