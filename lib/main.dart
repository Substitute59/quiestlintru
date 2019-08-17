import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/levels.dart';
import 'pages/game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the Home widget.
        '/': (context) => Home(),
        // When navigating to the "/levels" route, build the Levels widget.
        '/levels': (context) => Levels(),
        // When navigating to the "/game" route, build the Game widget.
        '/game': (context) => Game(),
      },
    );
  }
}