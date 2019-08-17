import 'package:flutter/material.dart';

import '../helpers/arguments.dart';
import '../models/user.dart';
import '../models/level.dart';

class Levelsgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLevels(),
      builder: (context, snapshot) {
        // Decode the JSON
        var newData = snapshot.data;

        return FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            var users = snapshot.data;

            return CustomScrollView(
              slivers: <Widget>[
                new SliverPadding(
                  padding: const EdgeInsets.all(5.0),
                  sliver: new SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var currentLevel = users != null ? users[0].level : 1;

                        return Container(
                          child: RawMaterialButton(
                            shape: CircleBorder(),
                            fillColor: currentLevel > index ? Colors.blue : Colors.grey,
                            onPressed: () {
                              if(currentLevel > index) {
                                Navigator.pushNamed(
                                  context,
                                  '/game',
                                  arguments: GameArguments(
                                    index+1,
                                    users[0].id,
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: new Text('Attention !'),
                                      content: new Text('Vous devez d\'abord terminer les niveaux précédents pour accèder à celui-ci.'),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text('Fermer'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                );
                              }
                            },
                            child: Text(
                              (index+1).toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: newData != null ? newData.length : 0,
                    ),
                  ),
                ),
              ]
            );
          }
        );
      }
    );
  }
}