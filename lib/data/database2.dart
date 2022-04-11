

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'profiling.dart';


class DatabaseHelper {
  static final _databaseName = "profiling.db";
  static final _databaseVersion = 5;
  // static final profilingTable = "profilingtable";

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await initDB();
  }

  initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade
    );
  }

  FutureOr<void> _onCreate(Database db, int version) {
    String sql = '''
  CREATE TABLE ProfilingTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    date INTEGER DEFAULT 0, 
    title String, 
    value INTEGER DEFAULT 0)
  ''';

    db.execute(sql);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {}

  // ignore: non_constant_identifier_names
  Future<void> InsertProfiling(Profiling item) async {
    var db = await database;

    await db.insert(
        'ProfilingTable',
        item.toMap()
    );
  }

}