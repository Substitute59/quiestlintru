import 'dart:convert';
import 'package:flutter/material.dart';

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
                      alignment: Alignment.center,
                      color: Colors.green,
                      child: Text((index+1).toString()),
                      height: 100.0,
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
}