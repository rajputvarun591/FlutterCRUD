import 'package:meta/meta.dart';
import 'package:notes/database_helper/database_helper.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

abstract class NotesService {
  Future<List<Notes>> getNotes({@required String columnName, @required String order});
  Future<Notes> loadSingleNote({@required int id});
  Future<int> updateNote({@required Notes notes});
  Future<int> addNote({@required Notes notes});
  Future<int> deleteNote({@required Notes note});

  Future<int> updateFavoriteStatus({@required Notes notes});
}

class FakeNoteService extends NotesService{
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<int> deleteNote({Notes note}) async{
    int response = await _databaseHelper.deleteNote(note.id);
    return response;
  }

  @override
  Future<List<Notes>> getNotes({String columnName, String order}) async{
    List<Notes> notes = await _databaseHelper.getNotes(10, 0, columnName, order);
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

  @override
  Future<int> updateFavoriteStatus({Notes notes}) async{
    int response = await _databaseHelper.updateFavoriteStatus(notes);
    return response;
  }

}