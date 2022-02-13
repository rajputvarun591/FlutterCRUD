import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

class SearchNotes extends SearchDelegate<Notes> {
  final Bloc<NotesEvent, NotesState> bloc;
  final List<Notes> list;
  SearchNotes({@required this.bloc, @required this.list});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (list.indexWhere((element) => element.title == query) >= 0) {
      return Scaffold(
          body: Container(
              padding: EdgeInsets.all(15.00),
              child: Material(
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(5.00)),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(5.00)),
                  child: Container(
                    padding: EdgeInsets.all(10.00),
                    decoration: BoxDecoration(
                      //color: index.isEven ? Colors.orange[200] : Colors.blue[200],
                      borderRadius: BorderRadius.all(Radius.circular(5.00)),
                      //boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.00, spreadRadius: 3.00)]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(child: Text(query, style: theme.textTheme.headline6)),
                        SizedBox(height: 5.00),
                        Container(
                            child: Text(
                          "${list[list.indexWhere((element) => element.title == query)].content}",
                          style: theme.textTheme.headline6,
                          overflow: TextOverflow.clip,
                        )),
                        SizedBox(height: 5.00),
                        Container(
                          child: Text(
                            MaterialLocalizations.of(context).formatShortDate(
                              DateTime.parse(
                                list[list.indexWhere((element) => element.title == query)].dateModified,
                              ),
                            ),
                            style: theme.textTheme.headline6,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              )));
    } else {
      return Container(
          alignment: Alignment.center,
          child: Text(
            "No Match Found!",
            style: theme.textTheme.headline6,
          ));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Notes> suggestionList =
        query.isEmpty ? list : list.where((element) => element.title.toLowerCase().startsWith(query.toLowerCase())).toList();
    return Container(
        child: ListView.separated(
            padding: EdgeInsets.all(10.00),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  child: Row(
                    children: [
                      Container(padding: EdgeInsets.all(5.00), child: Icon(Icons.search, color: Colors.grey)),
                      Container(
                        padding: EdgeInsets.all(5.00),
                        child: RichText(
                          text: TextSpan(
                            text: "${suggestionList[index].title.substring(0, query.length)}",
                            style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: suggestionList[index].title.substring(query.length),
                                style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  query = suggestionList[index].title;
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10.00);
            },
            itemCount: suggestionList.length));
  }
}
