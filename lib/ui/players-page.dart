import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:hive/hive.dart';
import 'package:logger_for_resistance/app/routing.dart';
import 'package:logger_for_resistance/entity/player.dart';

class PlayersPage extends StatefulWidget {
  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  Box<Player> playerBox = Hive.box('players');
  bool isGameNotStarted = false;
  String playerName = "";
  Color currentColor = Colors.green;
  final playerController = TextEditingController();
  int selected = 0;

  showColorPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose color'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: currentColor,
                onColorChanged: (color) {
                  setState(() {
                    currentColor = color;
                  });
                },
              ),
            ),
          );
        });
  }

  Card drawPlayerCard(Player player) {
    return Card(
      color: player.getColor(),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          player.getName(),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  List<Card> playersCards(Box<Player> box) {
    List<Card> result = new List();
    for (int i = 0; i < box.length; i++) {
      result.add(drawPlayerCard(box.getAt(i)));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lobby"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.games),
            onPressed: () {
              isGameNotStarted = true;
              Navigator.pushNamed(context, Router.gamePage);
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: playerController,
                    onChanged: (text) {
                      playerName = text;
                    },
                  ),
                ),
                IconButton(
                  color: currentColor,
                  icon: Icon(Icons.border_color),
                  onPressed: () {
                    setState(() {
                      showColorPicker();
                    });
                  },
                ),
              ],
            ),
            RaisedButton(
                child: Text('Add player'),
                onPressed: isGameNotStarted
                    ? null
                    : () {
                        setState(() {
                          playerController.clear();
                          playerBox.add(Player.withNameAndColor(
                              playerName, currentColor));
                        });
                      }),
            Expanded(
              child: ListView.builder(
                  itemCount: playerBox.length,
                  itemBuilder: (context, index) {
                    return playersCards(playerBox)[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
