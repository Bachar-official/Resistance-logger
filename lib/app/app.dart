import 'package:flutter/material.dart';
import 'package:resistance_log/app/routing.dart';

class App extends StatefulWidget{
  @override 
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Resistance logger',
      theme: ThemeData.dark(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}