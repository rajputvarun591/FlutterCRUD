import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/models/models.dart';
import 'package:notes/views/widgets/notes_list_view.dart';
import 'package:meta/meta.dart';

class TrashBin extends StatefulWidget {
  final List<Notes> trash;

  TrashBin({@required this.trash});

  @override
  _TrashBinState createState() => _TrashBinState();
}

class _TrashBinState extends State<TrashBin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Trash Bin"),
        ),
        body: NotesListView(trash: widget.trash),
      ),
      onWillPop: () => _onWillPop(context),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    BlocProvider.of<NotesBloc>(context)
        .add(ShowNotes(sortBy: Notes.columnDateModified, orderBy: Order.descending));
    return true;
  }
}
