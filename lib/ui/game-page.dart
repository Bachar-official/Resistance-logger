import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resistance_log/app/player.dart';
import 'package:resistance_log/app/round.dart';
import 'package:resistance_log/ui/game-progress.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

List<String> getNames(Box box) {
  List<String> result = new List();
  for (int i = 0; i < box.length; i++) {
    result.add(box.getAt(i) as String);
  }
  return result;
}

List<Player> setPlayersList(List<String> list) {
  List<Player> result = new List();
  for (int i = 0; i < list.length; i++) {
    result.add(new Player.withName(list[i]));
  }
  return result;
}

GameRound newRound(List<Player> players, OperationResult result) {
  return new GameRound.withList(players, result);
}

class _GamePageState extends State<GamePage> {
  static Box<String> playerBox = Hive.box('players');
  static Box<GameRound> roundBox = Hive.box('rounds');
  static List<String> playerName = getNames(playerBox);
  List<Player> players = setPlayersList(playerName);
  List<Container> playersContainer;

  Container buildContainer(Player player) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Text(player.getName()),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.verified_user),
                  Checkbox(
                    value: player.isCommander,
                    onChanged: (value) {
                      setState(() {
                        player.isCommander = value;
                      });
                    },
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.group),
                  Checkbox(
                    value: player.inTeam,
                    onChanged: (value) {
                      setState(() {
                        player.inTeam = value;
                      });
                    },
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.check),
                  Checkbox(
                    value: player.isVoted,
                    onChanged: (value) {
                      setState(() {
                        player.isVoted = value;
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
      color: Colors.green,
    );
  }

  List<Container> fillContainerList(List<Player> players) {
    List<Container> result = new List();
    for (int i = 0; i < players.length; i++) {
      result.add(buildContainer(players[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    playersContainer = fillContainerList(players);
    return Scaffold(
        appBar: AppBar(
          title: Text("Game"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Colors.blue,
                onPressed: () {
                  roundBox.add(GameRound.withList(players, OperationResult.SUCCESS));
                }),
            IconButton(
                icon: Icon(Icons.cancel), color: Colors.red, onPressed: () {
                  roundBox.add(newRound(players, OperationResult.FAIL));
                }),
            IconButton(
                icon: Icon(Icons.cached), color: Colors.grey, onPressed: () {
                  roundBox.add(newRound(players, OperationResult.NO_VOTE));
                }),
            IconButton(
                icon: Icon(Icons.screen_share),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameProgress()));
                }),
          ],
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: playersContainer,
        ));
  }
}
