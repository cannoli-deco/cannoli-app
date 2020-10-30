import 'dart:io';

import 'dart:async';
import 'package:cannoli_app/inputs/car_input.dart';
import 'package:cannoli_app/inputs/edit_entry.dart';
import 'package:cannoli_app/inputs/home_input.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
//  List<Map<String, dynamic>> columns;
//  DatabaseHelper(this.)

  // Change the dbname to reset the db lol
  static final _databaseName = "data1105sqlite";
  static final _databaseVersion = 2;

  static final table = 'Source';

  static final columnId = 'id';
  static final columnName = 'source_name';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE Source (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     source_name TEXT
     )
     """);

    await db.execute("""
    CREATE TABLE Entry (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
       consumption INTEGER,
       entry_date INTEGER,
        source_id INTEGER,
         FOREIGN KEY (source_id) REFERENCES Source(id)
         )
           """);

//    await db.batch()
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryEntryByDate(
      int timeStart, int timeEnd) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT * FROM Entry WHERE entry_date BETWEEN $timeStart and $timeEnd');
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<dynamic> queryBySourceName(String source) async {
    Database db = await instance.database;
    return await db
        .query('Source', where: 'source_name = ?', whereArgs: [source]);
  }
}

final dbHelper = DatabaseHelper.instance;

Future<void> addEntry(
    int consumption, DateTime entryDate, String source) async {
  WidgetsFlutterBinding.ensureInitialized();

  entryDate = new DateTime(
      entryDate.year, entryDate.month, entryDate.day, entryDate.hour - 10);

  Future<int> _getId() async {
    final row = await dbHelper.queryBySourceName(source);
    return row[0]['id'];
  }

  void _insert() async {
    Map<String, dynamic> row = {
      'consumption': consumption,
      'entry_date': entryDate.millisecondsSinceEpoch,
      'source_id': await _getId()
    };

    await dbHelper.insert('Entry', row);
  }

  _insert();
}

Future<void> editEntry(
    int id, int consumption, DateTime entryDate, String source) {
  WidgetsFlutterBinding.ensureInitialized();

  void _update() async {
    Map<String, dynamic> row = {
      'consumption': consumption,
      'entry_date': entryDate.millisecondsSinceEpoch,
      'source_id': await dbHelper.queryBySourceName(source),
    };
    await dbHelper.update('Entry', row);
  }

  _update();
}

Future<void> deleteEntry(int id) {
  WidgetsFlutterBinding.ensureInitialized();

  void _delete() async {
    await dbHelper.delete('Entry', id);
  }

  _delete();
}

Future<List<Entry>> allEntries() async {
  WidgetsFlutterBinding.ensureInitialized();

  _query() async {
    List<Entry> entryList = [];
    final allRows = await dbHelper.queryAllRows('Entry');
    await Future.forEach(allRows, (row) async {
      entryList.add(Entry.fromQuery(row));
    });
//     allRows.forEach((row) => entryList.add(Entry.fromQuery(row)));
    return entryList;
  }

  return _query();
}

Future<List<Entry>> entryFromDate(DateTime inputDay) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Converts Brisbane time to GST
  // Bad practice :(
  inputDay = new DateTime(
      inputDay.year, inputDay.month, inputDay.day, inputDay.hour - 10);

  int epochDayLength = 86400000;
  int startOfDay = inputDay.millisecondsSinceEpoch -
      (inputDay.millisecondsSinceEpoch % epochDayLength);
  int endOfDay = startOfDay + epochDayLength;

  _query() async {
    List<Entry> entryList = [];
    final allRows = await dbHelper.queryEntryByDate(startOfDay, endOfDay);
    await Future.forEach(allRows, (row) async {
      entryList.add(Entry.fromQuery(row));
    });
    return entryList;
  }

  return _query();
}

Future<void> main() async {}

/// Fills db with sources
// ignore: missing_return
Future<void> instantiateDB() {
  WidgetsFlutterBinding.ensureInitialized();

  void _insert() async {
    var defaultSources = [
      {
        'source_name': 'Home Energy',
      },
      {'source_name': 'Gas'},
      {'source_name': 'Transport'}
    ];

    await Future.forEach(defaultSources, (source) async {
      await dbHelper.insert('Source', source);
    });
  }

  _insert();
}

class Entry {
  // naming scheme based on db
  int id;
  int consumption;
  DateTime entry_date;
  int source_id;

  // use this for db input
  int get entryDate {
    return entry_date.millisecondsSinceEpoch;
  }

  Entry.fromQuery(Map<String, dynamic> query) {
    this.id = query['id'];
    this.consumption = query['consumption'];
    this.entry_date = DateTime.fromMillisecondsSinceEpoch(query['entry_date']);
    this.source_id = query['source_id'];
  }

  Entry({this.id, this.consumption, this.entry_date, this.source_id});

  @override
  String toString() {
    return "Entry " + this.consumption.toString();
  }
}
