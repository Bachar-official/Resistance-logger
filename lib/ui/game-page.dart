import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resistance_log/app/operations.dart';
import 'package:resistance_log/app/player.dart';
import 'package:resistance_log/app/round.dart';
import 'package:resistance_log/app/routing.dart';
import 'package:resistance_log/app_localizations.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static Box<String> playerBox = Hive.box('players');
  static List<String> playerName = Operations.getNames(playerBox);
  List<Container> playersContainer;
  List<Player> players = Operations.setPlayersList();
  int _selected = 0;
  List<Container> fillContainerList(List<Player> players) {
    List<Container> result = new List();
    for (int i = 0; i < players.length; i++) {
      result.add(buildContainer(players[i], i));
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
      _selected = value;
    });
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      onChanged(_selected);
    });
    setPlayerToCommander(_selected);
  }

  Container buildContainer(Player player, int index) {
    return Container(
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
                    groupValue: _selected,
                    onChanged: (int value) {
                      setState(() {
                        onChanged(value);
                      });
                      setPlayerToCommander(_selected);
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
                  ),
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
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      color: player.getColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Box<GameRound> roundBox = Hive.box('rounds');
    playersContainer = fillContainerList(players);
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('round') + " " + Operations.getRoundsCount().toString()),
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
