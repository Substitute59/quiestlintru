import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertUser(User user) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'users_database.db')
  );

  final Database db = await database;
  
  await db.insert(
    'users',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  db.close();
}

Future<List<User>> getUsers() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'users_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, level INTEGER)",
      );
    },
    version: 1,
  );

  final Database db = await database;

  executeQuery(db) {
    if(!db.isClosed) {
      return db.query('users');
    } else {
      return null;
    }
  }

  final List<Map<String, dynamic>> maps = await executeQuery(db);

  db.close();

  if(maps != null) {
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        level: maps[i]['level'],
      );
    });
  } else {
    return null;
  }
}

Future<void> updateUser(User user) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'users_database.db')
  );
  
  final db = await database;

  await db.update(
    'users',
    user.toMap(),
    where: "id = ?",
    whereArgs: [user.id],
  );

  db.close();
}

Future<void> deleteUser(int id) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'users_database.db')
  );
  
  final db = await database;

  await db.delete(
    'users',
    where: "id = ?",
    whereArgs: [id],
  );

  db.close();
}

class User {
  final int id;
  final String name;
  final int level;

  User({this.id, this.name, this.level});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'level': level,
    };
  }
}