import 'package:flutter/material.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.red,
                child: Text('Jouer'),
                onPressed: () {
                  // Navigate to the levels screen using a named route.
                  Navigator.pushNamed(context, '/levels');
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Niveaux'),
                onPressed: () {
                  // Navigate to the levels screen using a named route.
                  Navigator.pushNamed(context, '/levels');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}