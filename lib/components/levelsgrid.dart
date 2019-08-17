import 'dart:convert';
import 'package:flutter/material.dart';

import '../helpers/arguments.dart';
import '../models/user.dart';

class Levelsgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle
        .of(context)
        .loadString('lib/datas/datas.json'),
      builder: (context, snapshot) {
        // Decode the JSON
        var newData = json.decode(snapshot.data.toString());

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
                        return Container(
                          child: RawMaterialButton(
                            shape: CircleBorder(),
                            fillColor: users[0].level > index ? Colors.blue : Colors.grey,
                            onPressed: () {
                              if(users[0].level > index) {
                                Navigator.pushNamed(
                                  context,
                                  '/game',
                                  arguments: GameArguments(
                                    index+1,
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
                      childCount: newData.length,
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