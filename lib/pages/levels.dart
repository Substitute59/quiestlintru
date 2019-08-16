import 'package:flutter/material.dart';
import '../components/levelsgrid.dart';

class Levels extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _LevelsState();
  }
}

class _LevelsState extends State<Levels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qui est l\'intru ?'),
      ),
      body: Center(
        child: Levelsgrid(),
      ),
    );
  }
}