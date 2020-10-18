import 'dart:io' show Directory;
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:path/path.dart' show join;

import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';

import 'dart:developer' as dev;

class DatabaseHelper {

  static final _databaseName = "Notes.db";
  static final _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper.privateConstructor();
  static final DatabaseHelper _instance = DatabaseHelper.privateConstructor();
  factory DatabaseHelper() => _instance;

  // only have a single app-wide reference to the database
  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return _db = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute(Notes.createTable);
  }

  //insertion operation
  Future<int> saveNote(Notes notes) async {
    var dbClient = await database;
    int result = await dbClient.insert(Notes.tableName, notes.toMap());
    return result;
  }

  Future<List<Notes>> getNotes(int limit, int offSet, String columnName, String order) async {
    var dbClient = await database;
    List<dynamic> response = await dbClient.query("${Notes.tableName}", columns: [Notes.columnId, Notes.columnTitle, Notes.columnContent, Notes.columnDateTime, Notes.columnDateModified, Notes.columnFavorite], where: "${Notes.columnDelAction} = ?" , whereArgs: ["no"], orderBy: "$columnName $order");
    if(response.isEmpty) return [];
    List<Notes> notesList = response.map((e) => Notes.fromMap(e)).toList();
    return notesList;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await database;
    int response = await dbClient.delete(Notes.tableName, where: "${Notes.columnId} = ? ", whereArgs: [id]);
    return response;
  }

  Future<int> updateNotes(Notes notes) async {
    var dbClient = await database;
    int response = 0;
    try {
      response = await dbClient.rawUpdate("UPDATE ${Notes.tableName} SET ${Notes.columnTitle} = ?, ${Notes.columnContent} = ?, ${Notes.columnDateModified} = ? WHERE ${Notes.columnId} = ?", [notes.title, notes.content, notes.dateModified, notes.id]);
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
    return response;
  }

  Future close() async {
    var dbClient = await database;
    return await dbClient.close();
  }

  Future<Notes> getUpdatedNote(int id) async{
    var db = await database;
    List<Map<String, dynamic>> response = await db.query("${Notes.tableName}", columns: [Notes.columnId, Notes.columnTitle, Notes.columnContent, Notes.columnDateTime, Notes.columnDateModified], where: "${Notes.columnId} = ? ", whereArgs: [id]);
    Notes note = Notes.fromMap(response.first);
    return note;
  }

  Future<Notes> getSingleNote(int id) async{
    var dbClient = await database;
    List<dynamic> response = await dbClient.query("${Notes.tableName}", columns: [Notes.columnId, Notes.columnTitle, Notes.columnContent, Notes.columnDateTime, Notes.columnDateModified], where: "${Notes.columnId} = ? ", whereArgs: [id]);
    Notes note = response.map((e) => Notes.fromMap(e)).toList().first;
    return note;
  }

  Future<List<Notes>> getAllNotes() async{
    var db = await database;
    List<dynamic> notes = await db.query("${Notes.tableName}", columns: [Notes.columnId, Notes.columnTitle, Notes.columnDateTime, Notes.columnDateModified, Notes.columnContent], orderBy: "${Notes.columnTitle} ASC");
    List<Notes> notesList = notes.map((e) => Notes.fromMap(e)).toList();
    return notesList;
  }

  Future<int> updateFavoriteStatus(Notes notes) async{
    var db = await database;
    int response = await db.update(Notes.tableName, notes.toMapForFavorite(), where: "${Notes.columnId} = ?", whereArgs: [notes.id]);
    return response;
  }

  Future<List<Notes>> getTrashList(String columnName, String order) async{
    var dbClient = await database;
    List<dynamic> response = await dbClient.query("${Notes.tableName}", columns: [Notes.columnId, Notes.columnTitle, Notes.columnContent, Notes.columnDateTime, Notes.columnDateModified, Notes.columnFavorite], where: "delAction = ?" , whereArgs: ["yes"], orderBy: "$columnName $order");
    if(response.isEmpty) return [];
    List<Notes> notesList = response.map((e) => Notes.fromMap(e)).toList();
    return notesList;
  }

  Future<int> updateDelAction(Notes notes) async{
    var db = await database;
    int response = await db.update(Notes.tableName, notes.toMapForDelAction(), where: "${Notes.columnId} = ?", whereArgs: [notes.id]);
    return response;
  }

}