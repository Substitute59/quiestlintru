import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Level>> getLevels() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'levels_database.db')
  );

  final Database db = await database;

  executeQuery(db) {
    if(!db.isClosed) {
      return db.query('levels');
    } else {
      return null;
    }
  }

  final List<Map<String, dynamic>> maps = await executeQuery(db);

  db.close();

  if(maps != null) {
    return List.generate(maps.length, (i) {
      return Level(
        id: maps[i]['id'],
        images: maps[i]['images'],
        reponse: maps[i]['reponse'],
        raison: maps[i]['raison'],
      );
    });
  } else {
    return null;
  }
}

Future<List<Level>> getLevel(int id) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'levels_database.db')
  );

  final Database db = await database;

  executeQuery(db) {
    if(!db.isClosed) {
      return db.query(
        'levels',
        where: "id = ?",
        whereArgs: [id],
      );
    } else {
      return null;
    }
  }

  final List<Map<String, dynamic>> maps = await executeQuery(db);

  db.close();

  if(maps != null) {
    return List.generate(maps.length, (i) {
      return Level(
        id: maps[i]['id'],
        images: maps[i]['images'],
        reponse: maps[i]['reponse'],
        raison: maps[i]['raison'],
      );
    });
  } else {
    return null;
  }
}


class Level {
  final int id;
  final String images;
  final String reponse;
  final String raison;

  Level({this.id, this.images, this.reponse, this.raison});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'images': images,
      'reponse': reponse,
      'raison': raison,
    };
  }
}