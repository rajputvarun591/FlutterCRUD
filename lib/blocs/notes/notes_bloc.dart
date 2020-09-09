import 'package:bloc/bloc.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/services/services.dart';
import 'dart:developer' as dev;

class NotesBloc extends Bloc<NotesEvent, NotesState>{

  final NotesService _notesService;

  NotesBloc(NotesService notesService) : assert(notesService != null), _notesService = notesService;

  @override
  NotesState get initialState => InitialState();

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async*{
    if(event is ShowNotes) {
        yield* _mapShowNotesToEvent(event);
    }
    if (event is AddNote) {
      yield*  _mapAddNoteToEvent(event);
    }
    if (event is UpdateNote) {
      yield*  _mapUpdateNoteToEvent(event);
    }
    if (event is DeleteNote) {
      yield*  _mapDeleteNoteToEvent(event);
    }
    if (event is SortNotes) {
      yield*  _mapSortNotesToEvent(event);
    }
    if (event is UpdateFavoriteStatus) {
      yield*  _mapUpdateFavoriteStatusToEvent(event);
    }
  }

  Stream<NotesState> _mapShowNotesToEvent(ShowNotes event) async*{
    yield NotesLoading();
    try{
      final List<Notes> list = await _notesService.getNotes(columnName: event.columnName, order: event.order);
      if(list.isNotEmpty) {
        yield NotesLoaded(notes: list);
      } else {
        yield ZeroNotesFound(message: "Empty! Add Now");
      }
    } catch (e){
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapAddNoteToEvent(AddNote event) async*{
    //yield NotesLoading();
    try {
      final response = await _notesService.addNote(notes: event.notes);
      if (response == 0) {
        yield Failure(message: "Not Saved");
      } else {
        final List<Notes> list = await _notesService.getNotes(columnName: event.columnName, order: event.order);
        if(list.isNotEmpty) {
          yield NotesLoaded(notes: list);
        } else {
          yield ZeroNotesFound(message: "Empty! Add Now");
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapUpdateNoteToEvent(UpdateNote event) async*{
    //yield NotesLoading();
    try {
      final response = await _notesService.updateNote(notes: event.notes);
      if (response == 0) {
        yield Failure(message: "Not Updated");
      } else {
        final List<Notes> list = await _notesService.getNotes(columnName: event.columnName, order: event.order);
        if(list.isNotEmpty) {
          yield NotesLoaded(notes: list);
        } else {
          yield ZeroNotesFound(message: "Empty! Add Now");
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapDeleteNoteToEvent(DeleteNote event) async*{
    yield NotesLoading();
    try {
      final response = await _notesService.deleteNote(note: event.notes);
      if (response == 0) {
        yield Failure(message: "Not Updated");
      } else {
        final List<Notes> list = await _notesService.getNotes(columnName: event.columnName, order: event.order);
        if(list.isNotEmpty) {
          yield NotesLoaded(notes: list);
        } else {
          yield ZeroNotesFound(message: "Empty! Add Now");
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapSortNotesToEvent(SortNotes event) async*{
    //yield NotesLoading();
    try{
      final List<Notes> list = await _notesService.getNotes(columnName: event.columnName, order: event.order);
      if(list.isNotEmpty) {
        yield NotesLoaded(notes: list);
      } else {
        yield ZeroNotesFound(message: "Empty! Add Now");
      }
    } catch (e){
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapUpdateFavoriteStatusToEvent(UpdateFavoriteStatus event) async*{
    //yield NotesLoading();
    try {
      final response = await _notesService.updateFavoriteStatus(notes: event.notes);
      if (response == 0) {
        yield Failure(message: "Not Updated");
      } else {
        final List<Notes> list = await _notesService.getNotes(columnName: event.columnName, order: event.order);
        if(list.isNotEmpty) {
          yield NotesLoaded(notes: list);
        } else {
          yield ZeroNotesFound(message: "Empty! Add Now");
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

}