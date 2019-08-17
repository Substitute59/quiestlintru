import 'package:flutter/material.dart';

import '../helpers/arguments.dart';
import '../models/user.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUsers(),
      builder: (context, snapshot) {
        var users = snapshot.data;

        if(users != null && users.length > 0){
          return Scaffold(
            appBar: AppBar(
              title: Text('Qui est l\'intru ?'),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.white,
                        color: Colors.green,
                        child: Text(
                          'Jouer',
                          style: new TextStyle(
                            fontSize: 20.0,
                          )
                        ),
                        onPressed: () {
                          // Navigate to the levels screen using a named route.
                          Navigator.pushNamed(
                            context,
                            '/game',
                            arguments: GameArguments(
                              users[0].level,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(
                          'Niveaux',
                          style: new TextStyle(
                            fontSize: 20.0,
                          )
                        ),
                        onPressed: () {
                          // Navigate to the levels screen using a named route.
                          Navigator.pushNamed(
                            context,
                            '/levels'
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.white,
                        color: Colors.red,
                        child: Text(
                          'Effacer l\'avancement',
                          style: new TextStyle(
                            fontSize: 20.0,
                          )
                        ),
                        onPressed: () {
                          // Navigate to the levels screen using a named route.
                          deleteUser(0);
                          Navigator.pushReplacementNamed(
                            context,
                            '/'
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Qui est l\'intru ?'),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: userName,
                          style: new TextStyle(
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Votre nom',
                            hintStyle: new TextStyle(
                              fontSize: 20.0,
                            ),
                            contentPadding: const EdgeInsets.all(20.0),
                            errorStyle: TextStyle(
                              fontSize: 20.0,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Veuillez saisir votre nom';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          padding: const EdgeInsets.all(15.0),
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              final theUser = User(
                                id: 0, 
                                name: userName.text, 
                                level: 1,
                              );

                              insertUser(theUser);
                              Navigator.pushReplacementNamed(
                                context,
                                '/'
                              );
                            }
                          },
                          child: Text(
                            'Valider',
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }
    );
  }
}