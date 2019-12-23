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
  List<Player> players = Operations.getListFromBox();
  List<Container> playersContainer;
  int selected = 0;

  List<Container> fillPlayersContainer(List<Player> playerList) {
    List<Container> result = new List();
    for (int i = 0; i < playerList.length; i++) {
      result.add(drawPlayerContainer(playerList[i], i));
    }
    return result;
  }

  void setPlayerToCommander(int index) {
    for (int i = 0; i < players.length; i++) {
      if (i == index) {
        players[i].setCommander(true);
      } else {
        players[i].setCommander(false);
      }
    }
  }

  void onChanged(int value) {
    setState(() {
      selected = value;
    });
  }

  @override
  void initState() {
    setState(() {
      onChanged(selected);
      setPlayerToCommander(selected);
    });
  }

  Container drawPlayerContainer(Player player, int index) {
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
                    onChanged: (int value) {
                      setState(() {
                        onChanged(value);
                      });
                      setPlayerToCommander(selected);
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
                        setState(() {
                          player.setTeam(value);
                        });
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
                        setState(() {
                          player.setVote(value);
                        });
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

  @override
  Widget build(BuildContext context) {
    players.clear();
    players = Operations.getListFromBox();
    Box<Round> roundsBox = Hive.box('rounds');
    playersContainer = fillPlayersContainer(players);
    return Scaffold(
      appBar: AppBar(
        title: Text('R-d ' + (roundsBox.length + 1).toString()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check_circle),
            color: Colors.blue,
            onPressed: () {
              setState(() {
                roundsBox.add(Round.advanced(players, OperationResult.SUCCESS));
              });
              Navigator.popAndPushNamed(context, Router.gamePage);
            },
          ),
          IconButton(
            icon: Icon(Icons.cancel),
            color: Colors.red,
            onPressed: () {
              roundsBox.add(Round.advanced(players, OperationResult.FAIL));
              Navigator.popAndPushNamed(context, Router.gamePage);
            },
          ),
          IconButton(
            icon: Icon(Icons.cached),
            color: Colors.grey,
            onPressed: () {
              roundsBox.add(Round.advanced(players, OperationResult.NO_VOTE));
              Navigator.popAndPushNamed(context, Router.gamePage);
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
        children: playersContainer,
      ),
    );
  }
}
