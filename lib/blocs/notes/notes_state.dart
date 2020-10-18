import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class InitialState extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Notes> notes;
  final bool hasReachMAx;
  final String sortBy;
  final String orderBy;

  NotesLoaded({@required this.notes, @required this.hasReachMAx, this.sortBy, this.orderBy});

  NotesLoaded copyWith(List<Notes> notes, bool hasReachMax, String sortBy, String orderBy) {
    return NotesLoaded(
        notes: notes ?? this.notes,
        hasReachMAx: hasReachMax ?? this.hasReachMAx,
        sortBy: sortBy ?? this.sortBy,
        orderBy: orderBy ?? this.orderBy);
  }

  @override
  List<Object> get props => [notes, hasReachMAx];
}

class NotesFailure extends NotesState {
  final String message;

  NotesFailure({@required this.message});

  List<Object> get props => [message];
}

class TrashLoaded extends NotesState {
  final List<Notes> notes;

  TrashLoaded({@required this.notes});

  List<Object> get props => [notes];
}

class ZeroTrashFound extends NotesState {
  final String message;

  ZeroTrashFound({@required this.message});

  List<Object> get props => [message];
}
