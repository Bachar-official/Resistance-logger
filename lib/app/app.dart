import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger_for_resistance/app/routing.dart';

class App extends StatefulWidget{
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Resistance Logger",
      theme: ThemeData.dark(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}