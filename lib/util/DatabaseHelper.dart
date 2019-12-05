
import 'dart:io' show Directory;
import 'package:notes/model/Note.dart';
import 'package:path/path.dart' show join;

import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final _databaseName = "Notes.db";
  static final _databaseVersion = 1;

  static final table = 'notes';

  static final columnId = 'id';
  static final columnDateTime = 'dateTime';
  static final columnTitle = 'title';
  static final columnContent = 'content';


  // make this a singleton class
  DatabaseHelper._privateConstructor();


  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  factory DatabaseHelper() => instance;

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
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnDateTime TEXT NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnContent TEXT NOT NULL
          )
          ''');
  }


  //insertion operation
  Future<int> saveNote(Note note) async {
    var dbClient = await database;
    int result = await dbClient.insert("$table", note.toMap());
    return result;
  }

  Future<List> getNote() async {
    var dbClient = await database;
    var result = await dbClient.rawQuery("SELECT * FROM $table");
    return result.toList();
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await database;
    return await dbClient.delete(
        "$table", where: "$columnId = ? ", whereArgs: [id]);
  }

  Future<int> UpdateNote(Note note) async {
    var dbClient = await database;
    return await dbClient.update(
        table, note.toMap(), where: "$columnId = ?", whereArgs: [note.id]);
  }

  Future<List> getItems() async {
    var dbClient = await database;
    var result = await dbClient.rawQuery("SELECT * FROM $table ORDER BY $columnId ASC");
    return result.toList();
  }

  Future close() async {
    var dbClient = await database;
    return await dbClient.close();
  }
}