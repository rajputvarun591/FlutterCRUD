import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class ShowNotes extends NotesEvent{
  final String sortBy;
  final String orderBy;
  final int limit;
  final int offSet;

  ShowNotes({@required this.sortBy, @required this.orderBy, this.limit, this.offSet});

  @override
  List<Object> get props => [];
}

class AddNote extends NotesEvent{
  final Notes notes;

  AddNote({@required this.notes});

  @override
  List<Object> get props => [notes];
}

class DeleteNote extends NotesEvent{
  final Notes notes;

  DeleteNote({@required this.notes});

  @override
  List<Object> get props => [notes];

}

class UpdateNote extends NotesEvent{
  final Notes notes;

  UpdateNote({@required this.notes});

  @override
  List<Object> get props => [notes];
}

class UpdateFavoriteStatus extends NotesEvent{
  final Notes notes;

  UpdateFavoriteStatus({@required this.notes});

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

class LoadTrash extends NotesEvent{
  final List<Notes> notes;
  final String columnName;
  final String order;

  LoadTrash({@required this.notes, @required this.columnName, @required this.order});

  @override
  List<Object> get props => [notes];
}

class MoveToTrash extends NotesEvent{
  final Notes note;

  MoveToTrash({@required this.note});

  List<Object> get props => [note];
}

class RestoreFromTrash extends NotesEvent{
  final Notes note;

  RestoreFromTrash({@required this.note});

  List<Object> get props => [note];
}

