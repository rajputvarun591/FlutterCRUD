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
  final String columnName;
  final String order;
  ShowNotes({@required this.notes, @required this.columnName, @required this.order});

  @override
  List<Object> get props => [notes];
}

class AddNote extends NotesEvent{
  final Notes notes;
  final String columnName;
  final String order;

  AddNote({@required this.notes, @required this.columnName, @required this.order});

  @override
  List<Object> get props => [notes];
}

class DeleteNote extends NotesEvent{
  final Notes notes;
  final String columnName;
  final String order;

  DeleteNote({@required this.notes, @required this.columnName, @required this.order});

  @override
  List<Object> get props => [notes];

}

class UpdateNote extends NotesEvent{
  final Notes notes;
  final String columnName;
  final String order;

  UpdateNote({@required this.notes, @required this.columnName, @required this.order});

  @override
  List<Object> get props => [notes];
}

class UpdateFavoriteStatus extends NotesEvent{
  final Notes notes;
  final String columnName;
  final String order;

  UpdateFavoriteStatus({@required this.notes, @required this.columnName, @required this.order});

  @override
  List<Object> get props => [notes];
}

class SortNotes extends NotesEvent{
  final String columnName;
  final String order;

  SortNotes({@required this.columnName, @required this.order});

  @override
  List<Object> get props => [columnName, order];
}

