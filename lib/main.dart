import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/levels.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the MyAppHome widget.
        '/': (context) => Home(),
        // When navigating to the "/levels" route, build the MyAppLevels widget.
        '/levels': (context) => Levels(),
      },
    );
  }
}