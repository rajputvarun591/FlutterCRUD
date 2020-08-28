import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class ShowNotes extends NotesEvent{
  final List<Notes> notes;
  ShowNotes({@required this.notes});

  @override
  List<Object> get props => [notes];
}

class AddNote extends NotesEvent{
  final Notes notes;

  AddNote({@required this.notes});

  @override
  List<Object> get props => [notes];
}

class DeleteNote extends NotesEvent{

}

class UpdateNote extends NotesEvent{
  final Notes notes;

  UpdateNote({@required this.notes});

  @override
  List<Object> get props => [notes];
}

/*
class LoadSingleNote extends NotesEvent{
  final Notes note;

  LoadSingleNote({@required this.note});

  @override
  List<Object> get props => [note];
}*/
