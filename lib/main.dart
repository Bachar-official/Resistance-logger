import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'app/app.dart';

void main() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  var playersBox = await Hive.openBox('players');
  playersBox.clear();
  runApp(App());
}
//void main() => runApp(App());