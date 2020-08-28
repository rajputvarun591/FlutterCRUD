import 'package:flutter/cupertino.dart';
import 'package:notes/database_helper/database_helper.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

abstract class NotesService {
  Future<List<Notes>> getNotes();
  Future<Notes> loadSingleNote({@required int id});
  Future<int> updateNote({@required Notes notes});
  Future<int> addNote({@required Notes notes});
  Future<int> deleteNote();
}

class FakeNoteService extends NotesService{
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<int> deleteNote() {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<Notes>> getNotes() async{
    List<Notes> notes = await _databaseHelper.getNotes(10, 0);
    return notes;
  }

  @override
  Future<int> addNote({Notes notes}) async{
    int response = await _databaseHelper.saveNote(notes);
    return response;
  }

  @override
  Future<int> updateNote({Notes notes}) async{
    int response = await _databaseHelper.updateNotes(notes);
    return response;
  }

  @override
  Future<Notes> loadSingleNote({int id}) async{
    Notes notes = await _databaseHelper.getSingleNote(id);
    return notes;
  }

}