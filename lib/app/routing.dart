import 'package:flutter/material.dart';
import 'package:resistance_log/ui/game-page.dart';
import 'package:resistance_log/ui/game-progress.dart';
import 'package:resistance_log/ui/players-page.dart';

class Router {
  static Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case playersPage:
        return _buildRoute((context) => PlayersPage());
      case gamePage:
        return _buildRoute((context) => GamePage());
        case progressPage:
        return _buildRoute((context) => GameProgress());
      default:
        throw Exception("Unknown route: ${routeSettings.name}");
    }
  }

  static const String playersPage = "/";
  static const String gamePage = "/gamePage";
  static const String progressPage = "/progressPage";
}

Route _buildRoute(WidgetBuilder builder) {
  return MaterialPageRoute(builder: builder);
}
