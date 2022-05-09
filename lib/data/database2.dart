

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'profiling.dart';


class DatabaseHelper {
  static final _databaseName = "profiling.db";
  static final _databaseVersion = 1;
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
    count INTEGER DEFAULT 0, 
    time INTEGER DEFAULT 0, 
    CPUusage INTEGER DEFAULT 0,
    GPUusage INTEGER DEFAULT 0,
    CPU0Freq INTEGER DEFAULT 0,
    CPU4Freq INTEGER DEFAULT 0,
    CPU7Freq INTEGER DEFAULT 0,
    GPUFreq INTEGER DEFAULT 0,
    FPS INTEGER DEFAULT 0,
    Network INTEGER DEFAULT 0,
    Temp0 INTEGER DEFAULT 0, 
    ttime INTEGER DEFAULT 0,
    textf INTEGER DEFAULT 0,
    ddrclk INTEGER DEFAULT 0
    )
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

  Future<List<Profiling>> getAllProfilinig() async {
    var db = await database;

    // testTable 테이블에 있는 모든 field 값을 maps에 저장한다.
    final List<Map<String, dynamic>> maps = await db.query('ProfilingTable');

    return List.generate(maps.length, (index) {
      return Profiling(
          id: maps[index]['id'] as int,
          count: maps[index]['count'] as int,
          time: maps[index]['time'] as int,
          CPUusage: maps[index]['CPUusage'] as int,
          GPUusage: maps[index]['GPUusage'] as int,
          CPU0Freq: maps[index]['CPU0Freq'] as int,
          CPU4Freq: maps[index]['CPU4Freq'] as int,
          CPU7Freq: maps[index]['CPU7Freq'] as int,
          GPUFreq: maps[index]['GPUFreq'] as int,
          FPS: maps[index]['FPS'] as int,
          Network: maps[index]['Network'] as int,
          Temp0: maps[index]['Temp0'] as int,
          ttime: maps[index]['ttime'] as int,
          textf: maps[index]['textf'] as int,
          ddrclk: maps[index]['ddrclk'] as int,
      );
    });
  }

  Future<int> getLastRow() async {
    var db = await database;
    final data = await db.rawQuery('SELECT * FROM ProfilingTable');
    int lastCounter = 0;
    if(data.last['count'].toString().isEmpty)
      lastCounter = 0;
    else
      lastCounter = int.parse(data.last['count'].toString());

    // print(lastCounter);
    return lastCounter;
  }
  // Future<void> delAllProfilinig() async {
  //   var db = await database;
  //
  //   await db.delete(
  //       'ProfilingTable',
  //   );
  // }

}