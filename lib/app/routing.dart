import 'package:flutter/material.dart';
import 'package:logger_for_resistance/ui/game-page.dart';
import 'package:logger_for_resistance/ui/players-page.dart';
import 'package:logger_for_resistance/ui/game-progress.dart';

class Router{
  static Route generateRoute(RouteSettings routeSettings){
   switch(routeSettings.name){
     case playersPage: return _buildRoute((context) => PlayersPage());
     case gamePage: return _buildRoute((context) => GamePage());
     case progressPage: return _buildRoute((context) => GameProgressPage());
     default: throw Exception("Unknown route: ${routeSettings.name}");
   }
  }
  static const String playersPage = "/";
  static const String gamePage = "/gamePage";
  static const String progressPage = "/progressPage";
}

Route _buildRoute(WidgetBuilder builder){
  return MaterialPageRoute(builder: builder);
}
