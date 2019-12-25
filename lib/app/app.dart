import 'package:flutter/material.dart';
import 'package:resistance_log/app/routing.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../app_localizations.dart';

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
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      onGenerateRoute: Router.generateRoute,
    );
  }
}