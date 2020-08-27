import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/database_helper/database_helper.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/views/navigation_drawer/navigation_drawer.dart';
import 'package:notes/views/note_detail_view.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isGridUI;
  bool _isAdding;
  bool _hasText;

  FocusNode _focusNode;

  TextEditingController _tEController;

  @override
  void initState() {
    super.initState();
    print("initstate");
    _isGridUI = false;
    _isAdding =false;
    _hasText = false;
    _focusNode = FocusNode();
    _tEController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: <Widget>[
          IconButton(icon: Icon(_isGridUI ? Icons.list : Icons.apps, color: Colors.white70,), onPressed: () { setState(() {
            _isGridUI = !_isGridUI;
          });})
        ],
      ),
      drawer: NavigationDrawer(),
      body: Stack(
        children: [
          Container(
            child: FutureBuilder<List<Notes>>(
              future: getNotes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Notes> list = snapshot.data;
                  if(list.isEmpty) return Container(alignment: Alignment.center, child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.tag_faces, color: Colors.blue, size: 40.00),
                      SizedBox(height:20.00),
                      Text("Empty  List Create New!", style: TextStyle(fontSize: 20.00)),
                    ],
                  ));
                  return _isGridUI
                      ? Container(
                        child: GridView.count(
                          padding: EdgeInsets.all(15.00),
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.00,
                          mainAxisSpacing: 15.00,
                          scrollDirection: Axis.vertical,
                          children: List.generate(
                              list.length, (index) {
                                return Material(
                                  color: index.isEven ? Colors.orange[200] : Colors.blue[200],
                                  borderRadius: BorderRadius.all(Radius.circular(5.00)),
                                  child: InkWell(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 3,
                                      height: MediaQuery.of(context).size.height / 3,
                                      padding: EdgeInsets.all(10.00),
                                      decoration: BoxDecoration(
                                        //color: index.isEven ? Colors.orange[200] : Colors.blue[200],
                                        borderRadius: BorderRadius.all(Radius.circular(5.00)),
                                        //boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.00, spreadRadius: 3.00)]
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Hero(
                                                  tag: index,
                                                  transitionOnUserGestures: true,
                                                  flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                                                    return DefaultTextStyle(
                                                        style: DefaultTextStyle.of(toHeroContext).style,
                                                        child: toHeroContext.widget
                                                    );
                                                  },
                                                  child: Text("${list[index].title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00), overflow: TextOverflow.ellipsis,))),
                                          SizedBox(height: 5.00),
                                          Expanded(child: Container(alignment: Alignment.centerLeft, child: Text("${list[index].content}", style: TextStyle(color: Colors.blueGrey, fontSize: 18.00), overflow: TextOverflow.clip))),
                                          SizedBox(height: 5.00),
                                          Container(child: Text("${list[index].dateTime}", style: TextStyle(color: Colors.blueGrey))),
                                        ],
                                      ),
                                    ),
                                    onTap: () => _gridInkWellOnTap(list[index], index.isEven ? Colors.orange : Colors.blue, index),
                                  ),
                                );
                          }
                          ),
                        ),
                      )
                      : Container(
                        child: ListView.separated(
                          padding: EdgeInsets.all(15.00),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                          return Material(
                            color: index.isEven ? Colors.orange[200] : Colors.blue[200],
                            borderRadius: BorderRadius.all(Radius.circular(5.00)),
                            child: InkWell(
                              borderRadius: BorderRadius.all(Radius.circular(5.00)),
                              child: Container(
                                padding: EdgeInsets.all(10.00),
                                height: MediaQuery.of(context).size.height / 6,
                                decoration: BoxDecoration(
                                  //color: index.isEven ? Colors.orange[200] : Colors.blue[200],
                                  borderRadius: BorderRadius.all(Radius.circular(5.00)),
                                  //boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.00, spreadRadius: 3.00)]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Hero(
                                            tag: index,
                                            transitionOnUserGestures: true,
                                            flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                                              return DefaultTextStyle(
                                                  style: DefaultTextStyle.of(toHeroContext).style,
                                                  child: toHeroContext.widget
                                              );
                                            },
                                            child: Text("${list[index].title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00)))),
                                    Container(
                                        child: Text("${list[index].content}", style: TextStyle(color: Colors.blueGrey, fontSize: 18.00), overflow: TextOverflow.ellipsis,)),
                                    Container(
                                        child: Text("${list[index].dateTime}", style: TextStyle(color: Colors.blueGrey))),
                                  ],
                                ),
                              ),
                              onTap: () => _listInkWellOnTap(list[index], index.isEven ? Colors.orange : Colors.blue, index),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10.00);
                        },
                        itemCount: list.length
                  ),
                      ) ;
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error.toString()}"));
                } else {
                  return Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ));
                }
              }
            )
          ),
          Visibility(visible: _isAdding, child: Container(
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
                if(value.isNotEmpty) await saveNote(value);
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
      floatingActionButton: Visibility(
        visible: !_isAdding,
        child: FloatingActionButton(
          heroTag: "fab",
            tooltip: 'Add New Note',
            child: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _isAdding = true;
              });
            }),
      ),
    );
  }

  Future<List<Notes>> getNotes() async{
    List<Notes> notes = [];
    notes = await _databaseHelper.getNotes();
    return notes;
  }

  void _gridInkWellOnTap(Notes note, Color color, int index) async{
    bool isDeleted = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteDetailView(notes: note, color: color, index: index)));
    if(isDeleted ?? false) {
      setState(() {
        isDeleted = false;
      });
    }
  }

  void _listInkWellOnTap(Notes note, Color color, int index) async{
    bool isDeleted = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteDetailView(notes: note, color: color, index: index)));
    if(isDeleted ?? false) {
      setState(() {
        isDeleted = false;
      });
    }
  }

  Future<int> saveNote(String value) async{
    Notes notes = Notes(
        DateFormat("dd MMM hh:mm:a").format(DateTime.now()),
        "${value.split(" ")[0]} ${value.split(" ")[1]}",
        value,
        DateFormat("dd MMM hh:mm:a").format(DateTime.now()),
    );
    int response = await _databaseHelper.saveNote(notes);
    if(response != 0 ) {
      _tEController.clear();
      setState(() {

      });
      return response;
    }
    return 0;
  }

  @override
  void dispose() {
    _tEController.dispose();
    print("before dispose");
    super.dispose();
    print("dispose");
  }
}
