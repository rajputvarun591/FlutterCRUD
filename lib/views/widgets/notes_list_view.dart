import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/database_helper/database_helper.dart';
import 'package:notes/database_tables_models/notes.dart';

class NotesListView extends StatefulWidget {
  final List<Notes> trash;

  NotesListView({@required this.trash});

  @override
  _NotesListViewState createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> with SingleTickerProviderStateMixin{


  AnimationController _animationController;
  Animation<Offset> _animation;

  DatabaseHelper _databaseHelper;
  List<Notes> _list;

  final _textStyle = TextStyle(fontSize: 25.00, color: Colors.white, fontWeight: FontWeight.w600);

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<Offset>(begin: Offset(0.0, 3.0), end: Offset.zero).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut));
    super.initState();
    _databaseHelper = DatabaseHelper();
    _list = widget.trash;
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      child: widget.trash.length < 1 ? _emptyMessage() : ListView.separated(
          padding: EdgeInsets.all(15.00),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            _animationController.forward();
            return SlideTransition(
              position: _animation,
              child: Dismissible(
                key: Key(_list[index].id.toString()),
                onDismissed: (direction) async{
                  if(direction == DismissDirection.startToEnd){
                    int result = await _databaseHelper.deleteNote(_list[index].id);
                    if(result == 1){
                      setState(() {
                        _list.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Deleted!"), backgroundColor: Colors.red, duration: Duration(seconds: 2)));
                    }
                  }
                  if(direction == DismissDirection.endToStart){
                    Notes note = Notes.updateDelAction(_list[index].id, "no");
                    int result = await _databaseHelper.updateDelAction(note);
                    if(result == 1){
                      setState(() {
                        _list.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Restored!"), backgroundColor: Colors.green, duration: Duration(seconds: 2)));
                    }
                  }
                },
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5.00))
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 30.00),
                  child: Text("Delete", style: _textStyle),
                ),
                secondaryBackground: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(5.00))
                  ),
                  padding: EdgeInsets.only(right: 30.00),
                  alignment: Alignment.centerRight,
                  child: Text("Restore", style: _textStyle),
                ),
                child: Container(
                  padding: EdgeInsets.all(10.00),
                  height: mediaQuery.height / 6,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? theme.primaryColorDark.withOpacity(0.5)
                        : theme.primaryColorLight.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.00)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Hero(
                              tag: index,
                              transitionOnUserGestures: true,
                              flightShuttleBuilder: (flightContext,
                                  animation,
                                  flightDirection,
                                  fromHeroContext,
                                  toHeroContext) {
                                return DefaultTextStyle(
                                    style: DefaultTextStyle.of(toHeroContext)
                                        .style,
                                    child: toHeroContext.widget);
                              },
                              child: Text("${_list[index].title}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.00
                                  )
                              )
                          )
                      ),
                      Container(
                          child: Text(
                            "${_list[index].content}",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18.00
                            ),
                            overflow: TextOverflow.ellipsis,
                          )),
                      Container(
                          child: Text(
                              DateFormat("dd MMM hh:mm a").format(
                                  DateFormat("dd MMM yyyy hh:mm:ss:a")
                                      .parse(_list[index].dateModified)),
                              style: TextStyle(color: Colors.blueGrey
                              )
                          )
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index){
            return SizedBox(height: 10.00);
          },
          itemCount: _list.length
      ),
    );
  }

  Widget _emptyMessage() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.color_lens, size: 40.00, color: Colors.blue),
          SizedBox(height: 10.00),
          Text("Empty Trash!", style: TextStyle(fontSize: 20.00, color: Colors.blue, fontWeight: FontWeight.w300))
        ],
      ),
    );
  }
}
