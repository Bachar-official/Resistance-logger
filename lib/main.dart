
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:logger_for_resistance/app/app.dart';
import 'package:logger_for_resistance/entity/player.dart';
import 'package:logger_for_resistance/entity/round.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(PlayerAdapter(), 0);
  Hive.registerAdapter(RoundAdapter(), 1);
  Hive.registerAdapter(OperationResultAdapter(), 2);
  Box<Player> playerBox = await Hive.openBox('players');
  Box<Round> roundBox = await Hive.openBox('rounds');
  playerBox.clear();
  roundBox.clear();
  runApp(App());
}