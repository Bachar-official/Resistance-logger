import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:hive/hive.dart';
import 'package:resistance_log/app/player.dart';
import 'package:resistance_log/app/routing.dart';
import 'package:resistance_log/app_localizations.dart';

class PlayersPage extends StatefulWidget {
  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  List<Card> playersCard = new List();
  String player;
  Box<Player> playersBox = Hive.box('players-box');
  bool _isButtonDisabled = false;
  final playerController = TextEditingController();
  Color currentColor = Colors.green;

  showColorPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).translate('color')),
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
          player.getName() ?? '',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _isButtonDisabled
              ? null
              : () {
                  playersBox.add(Player.withNameAndColor(player, currentColor));
                  setState(() {
                    playersCard.add(drawPlayerCard(
                        Player.withNameAndColor(player, currentColor)));
                    playerController.clear();
                  });
                },
        ),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('lobby')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.games),
              onPressed: () {
                if (playersBox.length < 3) {
                  globalKey.currentState.showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(AppLocalizations.of(context).translate('small_lobby')),
                  ));
                } else {
                  _isButtonDisabled = true;
                  Navigator.pushNamed(context, Router.gamePage);
                }
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: playerController,
                    onChanged: (text) {
                      if (text.length > 0) player = text;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.border_color),
                  color: currentColor,
                  onPressed: showColorPicker,
                ),
              ],
            ),
            if (playersCard.length > 0)
              Expanded(
                child: ListView.builder(
                  itemCount: playersCard.length,
                  itemBuilder: (context, index) {
                    return playersCard[index];
                  },
                ),
              )
          ],
        ));
  }
}
