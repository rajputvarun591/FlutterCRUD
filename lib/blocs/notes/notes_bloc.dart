import 'package:bloc/bloc.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/services/services.dart';
import 'dart:developer' as dev;

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesService _notesService;

  NotesBloc(NotesService notesService)
      : assert(notesService != null),
        _notesService = notesService;

  @override
  NotesState get initialState => InitialState();

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    final currentState = state;

    if (event is ShowNotes) {
      yield* _mapShowNotesToEvent(event, currentState);
    }
    if (event is AddNote) {
      yield* _mapAddNoteToEvent(event, currentState);
    }
    if (event is UpdateNote) {
      yield* _mapUpdateNoteToEvent(event, currentState);
    }
    if (event is DeleteNote) {
      yield* _mapDeleteNoteToEvent(event, currentState);
    }
    if (event is SortNotes) {
      yield* _mapSortNotesToEvent(event, currentState);
    }
    if (event is UpdateFavoriteStatus) {
      yield* _mapUpdateFavoriteStatusToEvent(event, currentState);
    }
    if (event is MoveToTrash) {
      yield* _mapMoveToTrashToEvent(event, currentState);
    }
  }

  Stream<NotesState> _mapShowNotesToEvent(ShowNotes event, NotesState currentState) async* {
    try {
      /*if(currentState is InitialState) {
        final List<Notes> list = await _notesService.getNotes(columnName: event.sortBy, order: event.orderBy, limit: 8, offSet: 0);
        if (list.isNotEmpty) {
          yield NotesLoaded(notes: list, hasReachMAx: (list.length < 8), sortBy: event.sortBy, orderBy: event.orderBy);
        } else {
          yield ZeroNotesFound(message: "Empty! Add Now");
        }
      }
      if(currentState is NotesLoaded){
        final List<Notes> list = await _notesService.getNotes(columnName: event.sortBy, order: event.orderBy, limit: event.limit, offSet: event.offSet);
        if (list.isNotEmpty) {
          yield NotesLoaded(notes: currentState.notes + list, hasReachMAx: (list.length < 8), sortBy: event.sortBy, orderBy: event.orderBy);
        } else {
          yield currentState.copyWith(null, true, event.sortBy, event.orderBy);
        }
      }*/
      yield NotesLoading();
      final List<Notes> list = await _notesService.getNotes(columnName: event.sortBy, order: event.orderBy, limit: 8, offSet: 0);
      yield NotesLoaded(notes: list, hasReachMAx: (list.length < 8), sortBy: event.sortBy, orderBy: event.orderBy);
    } catch (e) {
      dev.log(e.toString(), time: DateTime.now());
    }
  }

  Stream<NotesState> _mapAddNoteToEvent(AddNote event, NotesState currentState) async* {
    try {
      final response = await _notesService.addNote(notes: event.notes);
      if (response == 0) {
        yield NotesFailure(message: "Not Saved");
      } else {
        if (currentState is NotesLoaded) {
          add(ShowNotes(sortBy: currentState.sortBy, orderBy: currentState.orderBy));
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapUpdateNoteToEvent(UpdateNote event, NotesState currentState) async* {
    yield NotesLoading();
    try {
      final response = await _notesService.updateNote(notes: event.notes);
      if (response == 0) {
        yield NotesFailure(message: "Not Updated");
      } else {
        if (currentState is NotesLoaded) {
          add(ShowNotes(sortBy: currentState.sortBy, orderBy: currentState.orderBy));
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapDeleteNoteToEvent(DeleteNote event, NotesState currentState) async* {
    yield NotesLoading();
    try {
      final response = await _notesService.deleteNote(note: event.notes);
      if (response == 0) {
        yield NotesFailure(message: "Not Deleted");
      } else {
        if (currentState is NotesLoaded) {
          add(ShowNotes(sortBy: currentState.sortBy, orderBy: currentState.orderBy));
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapSortNotesToEvent(SortNotes event, NotesState currentState) async* {
    //yield NotesLoading();
    try {
      if (currentState is NotesLoaded) {
        add(ShowNotes(sortBy: currentState.sortBy, orderBy: currentState.orderBy));
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapUpdateFavoriteStatusToEvent(
      UpdateFavoriteStatus event, NotesState currentState) async* {
    //yield NotesLoading();
    try {
      final response = await _notesService.updateFavoriteStatus(notes: event.notes);
      if (response == 0) {
        yield NotesFailure(message: "Not Updated");
      } else {
        if (currentState is NotesLoaded) {
          add(ShowNotes(sortBy: currentState.sortBy, orderBy: currentState.orderBy));
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  Stream<NotesState> _mapMoveToTrashToEvent(MoveToTrash event, NotesState currentState) async* {
    try {
      final response = await _notesService.updateDelAction(notes: event.note);
      if (response == 0) {
        yield NotesFailure(message: "Not Updated");
      } else {
        if (currentState is NotesLoaded) {
          add(ShowNotes(sortBy: currentState.sortBy, orderBy: currentState.orderBy));
        }
      }
    } catch (e) {
      dev.log(e, time: DateTime.now());
    }
  }

  bool _hasReachedMax(NotesState state) => state is NotesLoaded && state.hasReachMAx;

}
