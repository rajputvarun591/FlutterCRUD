import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/blocs/notes/notes_bloc.dart';
import 'package:notes/database_helper/database_helper.dart';
import 'package:notes/database_tables_models/notes.dart';

class NoteDetailView extends StatefulWidget {
  final Notes notes;
  final Color color;
  final int index;

  NoteDetailView({@required this.notes, @required this.color, @required this.index});

  @override
  _NoteDetailViewState createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isDeleting;
  bool _isEditing;
  final _noteDetailScaffoldKey = GlobalKey<ScaffoldState>();

  Notes _note;

  bool _hasText;

  FocusNode _focusNode;

  TextEditingController _tEController;


  @override
  void initState() {
    super.initState();
    _isDeleting = false;
    _isEditing= false;
    _hasText = false;
    _note = widget.notes;
    _focusNode = FocusNode();
    _tEController = TextEditingController(text: _note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _noteDetailScaffoldKey,
      appBar: AppBar(
        title: Hero(tag: widget.index, child: Text(_note.title)),
        backgroundColor: widget.color,
      ),
      body: Stack(
        children: [
          BlocBuilder(
            bloc: BlocProvider.of<NotesBloc>(context),
              builder: (context, state){
                if(state is NotesLoaded) {
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
                            child: Text("${state.notes[widget.index].dateTime}", style: TextStyle(fontSize: 18.00, color: Colors.blueGrey))),
                        InkWell(
                          child: Container(
                              padding: EdgeInsets.all(10.00),
                              child: Text("${state.notes[widget.index].content}", style: TextStyle(fontSize: 20.00, color: Colors.blueGrey))),
                          onTap: () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }
                else if (state is NotesLoading){
                  return Container(alignment: Alignment.center, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue)));
                }
                else if (state is NotesLoadFailure) {
                  return Container(alignment: Alignment.center, child: Text("Something went wrong please Try again"));
                }
                else {
                  return Container(alignment: Alignment.center, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue), strokeWidth: 2.00));
                }
          }),
          Container(
              child: Visibility(
                  visible: _isDeleting, child: Container(alignment:Alignment.center, color: Colors.black12, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(widget.color))))),
          Visibility(visible: _isEditing, child: Container(
            alignment: Alignment.bottomCenter,
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  suffixIcon: Visibility(visible: _hasText,child: IconButton(icon: Icon(Icons.clear, color: Colors.blueGrey), onPressed: () {
                    _tEController.clear();
                    setState(() {
                      _hasText = false;
                    });
                  }))
              ),
              autofocus: true,
              focusNode: _focusNode,
              controller: _tEController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              maxLengthEnforced: true,
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              onSubmitted: (value) async{
                final bloc = BlocProvider.of<NotesBloc>(context);
                if(value.isNotEmpty) {
                  Notes notes = Notes.update(
                    _note.id,
                    "${value.split(" ")[0]} ${value.split(" ")[1]}",
                    value,
                    DateFormat("dd MMM hh:mm:a").format(DateTime.now()),
                  );
                  bloc.add(UpdateNote(notes: notes));
                  bloc.close();
                }
              },
              onChanged: (value) {
                if(value.isNotEmpty) {
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
          ))
        ],
      ),
      floatingActionButton: Visibility(
        visible: !_isEditing,
        child: FloatingActionButton(
          heroTag: "fab",
          backgroundColor: widget.color,
          child: Icon(Icons.delete_outline),
            tooltip: "Delete This Note",
            onPressed: () => _fabOnPressed(context)
        ),
      ),
    );
  }

  _fabOnPressed(BuildContext context) async{
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Container(child: Text("Are you sure you want to delete this Note?")),
            actions: [
              FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Cancel")),
              FlatButton(onPressed: () async{
                  setState(() {
                    _isDeleting = true;
                  });
                  Navigator.of(context).pop();
                  await deleteNote(context, _note.id);
                }, child: Text("Delete")),
            ],
          );
        }
    );
  }

  Future<int> deleteNote(BuildContext context, int id) async{
    int response = await _databaseHelper.deleteNote(id);
    if(response != 0 ) {
      Navigator.of(context).pop(true);
      return response;
    } else {
      setState(() {
        _isDeleting = false;
      });
      _noteDetailScaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Container(child: Text("Deletion Failed")),
      ));
      return 0;
    }
  }

  Future<int> updateNote(String value) async{
    Notes notes = Notes.update(
        _note.id,
        "${value.split(" ")[0]} ${value.split(" ")[1]}",
        value,
        DateFormat("dd MMM hh:mm:a").format(DateTime.now())
    );
    int response = await _databaseHelper.updateNotes(notes);
    Future.delayed(Duration(seconds: 1), () async{
      _note = await _databaseHelper.getUpdatedNote(_note.id);
      setState(() {
        _isEditing = false;
      });
    });
  }
}
