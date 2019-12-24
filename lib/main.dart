import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:resistance_log/app/player.dart';
import 'package:resistance_log/app/round.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(PlayerAdapter(), 0);
  Hive.registerAdapter(GameRoundAdapter(), 1);
  Hive.registerAdapter(OperationResultAdapter(), 2);
  Box<String> playersBox = await Hive.openBox('players');
  Box<GameRound> roundsBox = await Hive.openBox('rounds');
  Box<Player> players = await Hive.openBox('players-box');
  players.clear();
  playersBox.clear();
  roundsBox.clear();
  runApp(App());
}
//void main() => runApp(App());