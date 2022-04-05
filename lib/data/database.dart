
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'profiling.dart';

class DatabaseHelper {
  static final _databaseName = "profiling.db";
  static final _databaseVersion = 1;
  static final profilingTable = "profiling";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $profilingTable (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     date INTEGER DEFAULT 0,
     title String
     value INTEGER DEFAULT 0
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<int> insertProfiling(Profiling profiling) async {
    Database db = await instance.database;

    if(profiling.id == null){
      Map<String, dynamic> row = {
        "title": profiling.title,
        "date": profiling.date,
        "value": profiling.value
      };
      return await db.insert(profilingTable, row);
    }else{
      Map<String, dynamic> row = {
        "title": profiling.title,
        "date": profiling.date,
        "value": profiling.value
      };
      return await db.update(profilingTable, row, where: "id = ?", whereArgs: [profiling.id]);
    }
  }

}