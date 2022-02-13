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

class _NotesListViewState extends State<NotesListView> with SingleTickerProviderStateMixin {
  DatabaseHelper _databaseHelper;
  List<Notes> _list;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _list = widget.trash;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      child: widget.trash.length < 1
          ? _emptyMessage()
          : ListView.separated(
              padding: EdgeInsets.all(15.00),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_list[index].id.toString()),
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      int result = await _databaseHelper.deleteNote(_list[index].id);
                      if (result == 1) {
                        setState(() {
                          _list.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Deleted!"),
                            duration: Duration(
                              seconds: 2,
                            ),
                          ),
                        );
                      }
                    }
                    if (direction == DismissDirection.endToStart) {
                      Notes note = Notes.updateDelAction(_list[index].id, "no");
                      int result = await _databaseHelper.updateDelAction(note);
                      if (result == 1) {
                        setState(() {
                          _list.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Restored!"),
                            duration: Duration(
                              seconds: 2,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  background: Container(
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(5.00))),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 30.00),
                    child: Text(
                      "Delete",
                      style: theme.textTheme.headline6,
                    ),
                  ),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(5.00))),
                    padding: EdgeInsets.only(right: 30.00),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Restore",
                      style: theme.textTheme.headline6,
                    ),
                  ),
                  child: ListTile(
                    tileColor: theme.backgroundColor,
                    title: Text(
                      "${_list[index].title}",
                      style: theme.textTheme.headline6.copyWith(fontSize: 17.00),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_list[index].content}",
                          style: theme.textTheme.headline6.copyWith(fontSize: 16.00),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                        Text(
                          MaterialLocalizations.of(context).formatShortDate(DateTime.parse(_list[index].dateModified)),
                          style: theme.textTheme.headline6.copyWith(fontSize: 15.00),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10.00);
              },
              itemCount: _list.length),
    );
  }

  Widget _emptyMessage() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.color_lens, size: 40.00),
          SizedBox(height: 10.00),
          Text(
            "Empty Trash!",
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
