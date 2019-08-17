import 'package:flutter/material.dart';

import '../helpers/arguments.dart';

class Game extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _GameState();
  }
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    final GameArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Niveau ${args.level}'),
      ),
      body: Center(
        child: Text('game'),
      ),
    );
  }
}