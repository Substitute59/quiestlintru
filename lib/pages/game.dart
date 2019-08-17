import 'package:flutter/material.dart';

import '../helpers/arguments.dart';
import '../models/user.dart';
import '../models/level.dart';

var attempt = 0;

class Game extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _GameState();
  }
}

class _GameState extends State<Game> {
  checkAnswerAndShowGoodDialog(args, image, levelInfos) {
    showDialog(
      context: context,
      builder: (context) {
        attempt++;
        if(image == levelInfos.reponse) {
          return FutureBuilder(
            future: getLevels(),
            builder: (context, snapshot) {
              var allLevels = snapshot.data;

              if(args.level == allLevels.length) {
                return AlertDialog(
                  title: new Text('Félicitations !'),
                  content: new Text('Vous avez terminé le jeu.'),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Retour à l\'accueil'),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/',
                        );
                      },
                    ),
                  ],
                );
              } else {
                updateUser(
                  User(
                    id: args.user,
                    level: args.level + 1,
                  ),
                );

                return AlertDialog(
                  title: new Text('Bravo !'),
                  content: new Text('Vous avez trouvé après ${attempt > 1 ? attempt.toString() + ' tentatives' : '1 tentative' }.\n\n${levelInfos.raison}.'),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Continuer'),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/game',
                          ModalRoute.withName('/'),
                          arguments: GameArguments(
                            args.level+1,
                            args.user,
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            }
          );
        } else {
          return AlertDialog(
            title: new Text('Et non !'),
            content: new Text('Essaie encore.'),
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
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final GameArguments args = ModalRoute.of(context).settings.arguments;

    return FutureBuilder(
      future: getLevel(args.level),
      builder: (context, snapshot) {
        var levels = snapshot.data;
        attempt = 0;

        if(levels != null) {
          var images = levels[0].images.split(',');

          return Scaffold(
            appBar: AppBar(
              title: Text('Niveau ${args.level}'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          checkAnswerAndShowGoodDialog(args, images[0], levels[0]);
                        },
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset('lib/assets/images/${images[0]}'),
                      ),
                      FlatButton(
                        onPressed: (){
                          checkAnswerAndShowGoodDialog(args, images[1], levels[0]);
                        },
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset('lib/assets/images/${images[1]}'),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          checkAnswerAndShowGoodDialog(args, images[2], levels[0]);
                        },
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset('lib/assets/images/${images[2]}'),
                      ),
                      FlatButton(
                        onPressed: (){
                          checkAnswerAndShowGoodDialog(args, images[3], levels[0]);
                        },
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset('lib/assets/images/${images[3]}'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Qui est l\'intru ?'),
            ),
            body: Center(
              child: Text('Chargement...'),
            ),
          );
        }
      }
    );
  }
}