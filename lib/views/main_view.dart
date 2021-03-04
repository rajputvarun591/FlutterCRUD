import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/blocs/notes/notes_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

import 'navigation_drawer/navigation_drawer.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  bool _isAdding;
  bool _hasText;

  FocusNode _focusNode;

  TextEditingController _tEController;

  Animation<double> _progress;
  AnimationController _animationController;
  NotesBloc _bloc;


  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400))..addListener(() {setState(() {});});
    _progress = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.75, curve: Curves.linear)));
    super.initState();
    _isAdding =false;
    _hasText = false;
    _focusNode = FocusNode();
    _tEController = TextEditingController();
    _bloc = BlocProvider.of<NotesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(progress: _progress, animationController: _animationController),
      drawer: NavigationDrawer(),
      body: GestureDetector(
        onTap: (){
          setState(() {
            _isAdding = false;
          });
        },
        child: Stack(
          children: [
            BlocBuilder(
              cubit: _bloc,
                builder: (context, state){
                  if(state is NotesLoaded){
                    return NotesGridView(state: state);
                  }
                  else if (state is NotesLoading){
                    return _notesLoadingWidget(context);
                  }
                  else if (state is NotesFailure) {
                    return _failureWidget(context, state);
                  }
                  else {
                    return _circularProgressIndicator(context);
                  }
                }
            ),
            Visibility(visible: (_isAdding), child: Container(
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
                  if(value.isNotEmpty) {
                    Notes notes = Notes(
                      DateFormat("dd MMM yyyy hh:mm:ss:a").format(DateTime.now()),
                      "${value.contains(" ") ? "${value.split(" ")[0]} ${value.split(" ")[1]}" : "${value.split(" ")[0]}"}",
                      value,
                      DateFormat("dd MMM yyyy hh:mm:ss:a").format(DateTime.now()),
                      "no", "no"
                    );
                    _bloc.add(AddNote(notes: notes));
                    _tEController.clear();
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
                    _isAdding = false;
                  });
                },
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: (!_isAdding),
        child: FloatingActionButton(
            heroTag: "fab",
            tooltip: 'Add New Note',
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _isAdding = true;
              });
            }
        ),
      )
    );
  }


  @override
  void dispose() {
    _tEController.dispose();
    super.dispose();
    _bloc.close();
  }

  Widget _notesLoadingWidget(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue)
        )
    );
  }

  Widget _failureWidget(BuildContext context, NotesFailure state) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, color: Theme.of(context).primaryColor, size: 50.00),
              SizedBox(height: 15.00),
              Text(state.message, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25.00)),
            ],
        ));
  }

  Widget _circularProgressIndicator(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            strokeWidth: 2.00
        )
    );
  }

}
