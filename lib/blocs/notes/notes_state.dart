import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class InitialState extends NotesState{}

class LoadNotes extends NotesState {
  final List<Notes> notes;
  LoadNotes({@required this.notes});

  @override
  List<Object> get props => [notes];
}

class NotesLoading extends NotesState{}

class NotesLoaded extends NotesState{
  final List<Notes> notes;
  NotesLoaded({@required this.notes});

  @override
  List<Object> get props => [notes];
}

class ZeroNotesFound extends NotesState{
  final String message;
  ZeroNotesFound({@required this.message});

  List<Object> get props => [message];
}

class Failure extends NotesState{
  final String message;
  Failure({@required this.message});

  List<Object> get props => [message];
}