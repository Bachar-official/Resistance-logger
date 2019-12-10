import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resistance_log/app/routing.dart';

class PlayersPage extends StatefulWidget {
  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  String player;
  var playersBox = Hive.box('players');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.games),
            onPressed: () {
              Navigator.pushNamed(context, Router.gamePage);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (text) {
              if(text.length > 0)player = text;
            },
          ),
          RaisedButton(
            onPressed: () {
              playersBox.add(player);
            },
            child: Text("Add player"),
          )
        ],
      ),
    );
  }
}
