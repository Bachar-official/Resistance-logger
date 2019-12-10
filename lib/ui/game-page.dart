import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static var playersBox = Hive.box('players');
  List<String> players = _fillFromBox(playersBox);
  List<bool> votes = createBools(playersBox.length);
  List<bool> mission = createBools(playersBox.length);
  List<bool> commander = createBools(playersBox.length);
  List<Widget> moves = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Game"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check_circle),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  moves.add(addCard(true, false, true, "success"));
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              color: Colors.red,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.cached),
              color: Colors.grey,
              onPressed: () {},
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, i) {
            String playerName = players[i];
            return Card(
              color: Colors.green,
              child: Row(
                children: <Widget>[
                  RotatedBox(
                    child: Text(playerName),
                    quarterTurns: -1,
                  ),
                  Column(
                    children: <Widget>[
                      Checkbox(
                        value: votes[i],
                        onChanged: (value) {
                          setState(() {
                            votes[i] = value;
                          });
                        },
                      ),
                      Checkbox(
                        value: mission[i],
                        onChanged: (value) {
                          setState(() {
                            mission[i] = value;
                          });
                        },
                      ),
                      Checkbox(
                        value: commander[i],
                        onChanged: (value) {
                          setState(() {
                            commander[i] = value;
                          });
                        },
                      )
                    ],
                  ),
                  Row(children: moves),
                ],
              ),
            );
          },
        ));
  }
}

Color cardColor(String operation) {
  switch (operation) {
    case "success":
      return Colors.blue;
    case "fail":
      return Colors.red;
    default:
      return Colors.grey;
  }
}

Column chooseOperations(bool comm, bool team, bool vote) {
  Column beenAndPro =
      Column(children: <Widget>[Icon(Icons.mood), Icon(Icons.check)]);
  Column beenAndContra =
      Column(children: <Widget>[Icon(Icons.mood), Icon(Icons.clear)]);
  Column notBeenAndPro =
      Column(children: <Widget>[Icon(Icons.mood_bad), Icon(Icons.check)]);
  Column notBeenAndContra =
      Column(children: <Widget>[Icon(Icons.mood_bad), Icon(Icons.clear)]);
  Column commBeenAndPro = Column(children: <Widget>[
    Icon(Icons.business_center),
    Icon(Icons.mood),
    Icon(Icons.check)
  ]);
  Column commBeenAndContra = Column(children: <Widget>[
    Icon(Icons.business_center),
    Icon(Icons.mood),
    Icon(Icons.clear)
  ]);
  Column commNotBeenAndPro = Column(children: <Widget>[
    Icon(Icons.business_center),
    Icon(Icons.mood_bad),
    Icon(Icons.check)
  ]);
  Column commNotBeenAndContra = Column(children: <Widget>[
    Icon(Icons.business_center),
    Icon(Icons.mood_bad),
    Icon(Icons.clear)
  ]);
  if (comm && team && vote)
    return commBeenAndPro;
  else if (comm && team && !vote)
    return commBeenAndContra;
  else if (comm && !team && vote)
    return commNotBeenAndPro;
  else if (comm && !team && !vote)
    return commNotBeenAndContra;
  else if (!comm && team && vote)
    return beenAndPro;
  else if (!comm && team && !vote)
    return beenAndContra;
  else if (!comm && !team && vote)
    return notBeenAndPro;
  else
    return notBeenAndContra;
}

Card addCard(bool comm, bool team, bool vote, String operation) {
  return Card(
      color: cardColor(operation), child: chooseOperations(comm, team, vote));
}

List<bool> createBools(int length) {
  List<bool> result = new List(length);
  for (int i = 0; i < length; i++) {
    result[i] = false;
  }
  return result;
}

List<String> _fillFromBox(var box) {
  List<String> result = new List();
  for (int i = 0; i < box.length; i++) {
    result.add(box.getAt(i) as String);
  }
  return result;
}
/*
child: Column(children: <Widget>[
      RaisedButton(color: Colors.red, child: Text("Fail"), onPressed: () {},),
      RaisedButton(color: Colors.blue, child: Text("Success"), onPressed: () {},),
      RaisedButton(color: Colors.grey, child: Text("Not accepted"), onPressed: () {},),
      Container(child: ListView.builder(
        itemCount: playersBox.length,
        itemBuilder: (context, index){
          String playerName = playersBox.getAt(index) as String;
          return ListTile(
            title: Text(playerName),
          );
        },
      ),)
    ],),
*/
