import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:CrudFutebol/model/futebol.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

 void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE futebol(id INTEGER PRIMARY KEY,nome TEXT, fundacao TEXT, presidente TEXT, mascote TEXT)');
  }

  Future<int> inserirFutebol(Futebol futebol) async {
    var dbClient = await db;
    var result = await dbClient.insert("futebol", futebol.toMap());

    return result;
  }

  Future<List> getFutebols() async {
    var dbClient = await db;
    var result = await dbClient.query("futebol", columns: ["id", "nome", "fundacao", "presidente", "mascote"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM futebol'));
  }
Future<Futebol> getFutebol(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("futebol",
        columns: ["id", "nome", "fundacao", "presidente", "mascote"], where: 'ide = ?', whereArgs: [id]);
    if (result.length > 0) {
      return new Futebol.fromMap(result.first);
    }
    return null;
  }
Future<int> deleteFutebol(int id) async {
    var dbClient = await db;
    return await dbClient.delete("futebol", where: 'id = ?', whereArgs: [id]);
  }
Future<int> updateFutebol(Futebol futebol) async {
    var dbClient = await db;
    return await dbClient.update("futebol", futebol.toMap(),
        where: "id = ?", whereArgs: [futebol.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
