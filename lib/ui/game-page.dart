import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resistance_log/app/operations.dart';
import 'package:resistance_log/app/player.dart';
import 'package:resistance_log/app/round.dart';
import 'package:resistance_log/app/routing.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static Box<String> playerBox = Hive.box('players');
  static List<String> playerName = Operations.getNames(playerBox);
  List<Container> playersContainer;
  List<Player> players = Operations.setPlayersList(playerName);

  List<Container> fillContainerList(List<Player> players) {
    List<Container> result = new List();
    for (int i = 0; i < players.length; i++) {
      result.add(buildContainer(players[i]));
    }
    return result;
  }

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
                    value: player.getCommander(),
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
                    value: player.getTeam(),
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
                    value: player.getVote(),
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

  @override
  Widget build(BuildContext context) {
    Box<GameRound> roundBox = Hive.box('rounds');
    playersContainer = fillContainerList(players);
    return Scaffold(
        appBar: AppBar(
          title: Text("Game"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Colors.blue,
                onPressed: () {
                  roundBox.add(
                      Operations.newRound(players, OperationResult.SUCCESS));
                  Navigator.popAndPushNamed(context, Router.gamePage);
                }),
            IconButton(
                icon: Icon(Icons.cancel),
                color: Colors.red,
                onPressed: () {
                  roundBox
                      .add(Operations.newRound(players, OperationResult.FAIL));
                  Navigator.popAndPushNamed(context, Router.gamePage);
                }),
            IconButton(
                icon: Icon(Icons.cached),
                color: Colors.grey,
                onPressed: () {
                  roundBox.add(
                      Operations.newRound(players, OperationResult.NO_VOTE));
                  Navigator.popAndPushNamed(context, Router.gamePage);
                }),
            IconButton(
                icon: Icon(Icons.screen_share),
                onPressed: () {
                  Navigator.pushNamed(context, Router.progressPage);
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
