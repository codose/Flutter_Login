import 'package:login_forms/data/models/User.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'package:path/path.dart';

import 'dart:io' as io;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User (id INTEGER PRIMARY KEY, username TEXT,  password TEXT, fullname TEXT)");
  }

//Insertion
  Future<String> saveUser(User user) async {
    var dbClient = await db;
    await dbClient.insert("User", user.toMap());
    return "Success";
  }

  Future<User> getUser(User user) async {
    var dbClient = await db;
    var user2;
    var result = await dbClient.rawQuery('SELECT * FROM User');

    result.forEach((element) {
      if (element.containsValue(user.username)) {
        var mUser = User.map(element);
        if (mUser.password == user.password) {
          user2 = User.map(element);
        }
      } else {
        return null;
      }
    });
    return user2;
  }

  //Deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
}
