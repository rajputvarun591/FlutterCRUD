import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/database_tables_models/notes.dart';
import 'package:notes/views/widgets/save_pdf_general_dialog.dart';

class NoteDetailView extends StatefulWidget {
  final Notes notes;

  const NoteDetailView({Key key, @required this.notes}) : super(key: key);

  @override
  _NoteDetailViewState createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  bool _isEditing;
  bool _hasText;
  Notes _note;
  FocusNode _focusNode;
  TextEditingController _tEController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _isEditing = false;
    _hasText = false;
    _note = widget.notes;
    _focusNode = FocusNode();
    _tEController = TextEditingController(text: _note.content);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Hero(tag: widget.notes.id, child: Text(_note.title)),
        actions: [
          IconButton(
              icon: Icon(Icons.file_download),
              tooltip: "Save as PDF",
              onPressed: () async {
                await showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black45,
                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return SavePdfGeneralDialog(note: _note);
                    }).then((value) {
                  if (value != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("File Downloaded !"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                });
              }),
          IconButton(
              icon: Icon(Icons.info_outline),
              tooltip: "Details",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text(
                          "Details",
                          style: theme.textTheme.headline6,
                        ),
                        contentPadding: EdgeInsets.all(10.00),
                        backgroundColor: theme.backgroundColor,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 15.00),
                              child: Text("Date Created", style: theme.textTheme.headline6.copyWith(fontSize: 18.00))),
                          Container(
                              padding: EdgeInsets.only(left: 20.00),
                              child: Text("${widget.notes.dateTime}", style: theme.textTheme.headline6.copyWith(fontSize: 15.00))),
                          SizedBox(height: 10.00),
                          Container(
                              padding: EdgeInsets.only(left: 15.00),
                              child: Text("Date Modified", style: theme.textTheme.headline6.copyWith(fontSize: 18.00))),
                          Container(
                              padding: EdgeInsets.only(left: 20.00),
                              child: Text("${widget.notes.dateModified}", style: theme.textTheme.headline6.copyWith(fontSize: 15.00))),
                          SizedBox(height: 10.00),
                          Container(
                              padding: EdgeInsets.only(left: 15.00),
                              child: Text("Total Chars", style: theme.textTheme.headline6.copyWith(fontSize: 18.00))),
                          Container(
                              padding: EdgeInsets.only(left: 20.00),
                              child: Text("${widget.notes.content.length}", style: theme.textTheme.headline6.copyWith(fontSize: 15.00))),
                          SizedBox(height: 10.00),
                        ],
                      );
                    });
              }),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder(
              cubit: BlocProvider.of<NotesBloc>(context),
              builder: (context, state) {
                if (state is NotesLoaded) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(15.00),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10.00, bottom: 10.00),
                            child: Text(
                                "${state.notes.firstWhere((element) => element.id == widget.notes.id, orElse: () => Notes("", "", "", "", "", "")).dateModified}",
                                style: theme.textTheme.headline6.copyWith(fontSize: 18.00))),
                        InkWell(
                          child: Container(
                              padding: EdgeInsets.all(10.00),
                              child: Text(
                                  "${state.notes.firstWhere((element) => element.id == widget.notes.id, orElse: () => Notes("", "", "", "", "", "")).content}",
                                  style: theme.textTheme.headline6.copyWith(fontSize: 20.00))),
                          onTap: () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                } else if (state is NotesLoading) {
                  return Container(
                      alignment: Alignment.center, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue)));
                } else {
                  return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue), strokeWidth: 2.00));
                }
              }),
          Visibility(
              visible: _isEditing,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  minimum: const EdgeInsets.all(10.00),
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.00),
                          borderSide: BorderSide(width: 2.00, color: Colors.transparent),
                        ),
                        suffixIcon: Visibility(
                            visible: _hasText,
                            child: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _tEController.clear();
                                  setState(() {
                                    _hasText = false;
                                  });
                                }))),
                    autofocus: true,
                    focusNode: _focusNode,
                    controller: _tEController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    maxLengthEnforced: true,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        Notes notes = Notes.update(
                          _note.id,
                          "${value.contains(" ") ? "${value.split(" ")[0]} ${value.split(" ")[1]}" : "${value.split(" ")[0]}"}",
                          value,
                          DateTime.now().toIso8601String(),
                        );
                        BlocProvider.of<NotesBloc>(context).add(UpdateNote(notes: notes));
                      }
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _hasText = true;
                        });
                      }
                    },
                    onEditingComplete: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                  ),
                ),
              ))
        ],
      ),
      floatingActionButton: Visibility(
        visible: !_isEditing,
        child: FloatingActionButton(
            heroTag: "fab", child: Icon(Icons.delete_outline), tooltip: "Delete This Note", onPressed: () => _fabOnPressed(context)),
      ),
    );
  }

  _fabOnPressed(BuildContext context) async {
    final theme = Theme.of(context);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: theme.backgroundColor,
            title: Container(child: Text("Are you sure you want to delete this Note?", style: theme.textTheme.headline6)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await deleteNote(context, _note);
                  },
                  child: Text("Delete")),
            ],
          );
        });
  }

  Future<int> deleteNote(BuildContext context, Notes note) async {
    Notes notes = Notes.updateDelAction(note.id, "yes");
    BlocProvider.of<NotesBloc>(context).add(MoveToTrash(note: notes));
    Navigator.pop<int>(context, 1);
    return 1;
  }
}
