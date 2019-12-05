import 'package:flutter/material.dart';
import 'package:notes/model/Note.dart';
import 'package:notes/ui/AddNote.dart';
import 'package:notes/util/DatabaseHelper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Note> _itemList = <Note>[];

  var dbClient = new DatabaseHelper();

  Note _notes;

  @override
  void initState() {
    super.initState();
    _readList();
  }

  _readList() async{
    List items = await dbClient.getItems();
    items.forEach((item){
      setState(() {
        _itemList.add(Note.map(item));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Notes" , style: TextStyle(
          color: Colors.white70,
          fontStyle: FontStyle.italic,
          fontFamily: 'Pacifico',
          fontWeight: FontWeight.w400,
          fontSize: 25
        ),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.grid_on, color: Colors.white70,), onPressed: () { })
        ],

      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( begin: Alignment.topCenter, end: Alignment.bottomCenter ,colors: [Colors.white70, Colors.white70]),
        ),

        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                  reverse: false,
                    itemCount: _itemList.length ,
                    itemBuilder: (_, int index){
                      return Card(
                        color: Colors.cyan,
                        child: new ListTile(
                          title: Text(_itemList[index].title),
                        ),
                      );
                    }
                )
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.cyan,tooltip: 'Add New Note', child: Icon(Icons.add, color: Colors.white70, size: 35.0, ),onPressed: () => _addNote ()),
    );
  }

  _addNote () {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return AddNote();
    }));
  }
}
