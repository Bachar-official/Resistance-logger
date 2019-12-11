import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resistance_log/app/routing.dart';

class PlayersPage extends StatefulWidget {
  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  List<Card> playersCard = new List();
  String player;
  Box playersBox = Hive.box('players');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lobby"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                playersBox.clear();
                setState(() {
                  playersCard.clear();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.games),
              onPressed: () {
                Navigator.pushNamed(context, Router.gamePage);
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            TextField(
              onChanged: (text) {
                if (text.length > 0) player = text;
              },
            ),
            RaisedButton(
              onPressed: () {
                playersBox.add(player);
                setState(() {
                  playersCard.add(Card(
                      color: Colors.green,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          player,
                          style: TextStyle(fontSize: 20),
                        ),
                      )));
                });
              },
              child: Text("Add player"),
            ),
            if (playersCard.length > 0)
              Expanded(
                child: ListView.builder(
                  itemCount: playersBox.length,
                  itemBuilder: (context, index) {
                    return playersCard[index];
                  },
                ),
              )
          ],
        ));
  }
}
