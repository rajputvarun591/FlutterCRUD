
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/model/Note.dart';
import 'package:notes/ui/NotePadHome.dart';
import 'package:notes/util/DatabaseHelper.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  var dbClient = new DatabaseHelper();

  String titleValue = "";

  String _date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Add Notes",
          style: TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.w400,
              fontSize: 20),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(5.0),
          child: ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                        child: TextField(
                          onChanged: _enableButton,
                            controller: _titleController,
                            maxLength: 15,
                            showCursor: true,
                            cursorColor: Colors.white70,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              filled: true,
                              fillColor: Colors.cyan,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(color: Colors.cyan)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(
                                    color: Colors.cyan,
                                  )),
                              prefixIcon: Icon(
                                Icons.edit,
                                color: Colors.white70,
                              ),
                            ))),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          child: TextField(
                            controller: _contentController,
                        textAlign: TextAlign.center,
                        maxLength: 200,
                        maxLines: 20,
                        minLines: 10,
                        showCursor: true, cursorColor: Colors.cyan,
                        decoration: InputDecoration(
                          hintText: 'please add some content',
                          hintStyle: TextStyle(
                              color: Colors.cyan,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        child:MaterialButton(
                          splashColor: Colors.cyanAccent,
                          height: 50,
                          minWidth: 400,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                          color: Colors.cyan,
                          child: Container(

                            child: Text('Save',
                              style: TextStyle(color: Colors.white70, fontSize: 20),
                            ),
                          ),
                          onPressed: () => _save(_titleController.text, _contentController.text, context),
                        ),
                      ),
                    )
                  ],
                );
              })),
    );
  }

 Future _save (String text, String text2, BuildContext context) async{
    if(titleValue == "" || titleValue == null || titleValue.isEmpty || titleValue == " "){
      return Scaffold.of(context).showSnackBar( new SnackBar(content: Text('Please add a valid title',textAlign: TextAlign.center,style: TextStyle(color: Colors.white70),),backgroundColor: Colors.redAccent,));
    }

    Note _note = new Note(_date, text, text2);
   var result = await dbClient.saveNote(_note);
    print(result);
    _titleController.clear();
    _contentController.clear();
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return HomeScreen();
    }));
 }

  void _enableButton(String value) {
    titleValue = value;
    print(value);
    }
}
