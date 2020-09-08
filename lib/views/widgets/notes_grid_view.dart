import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:meta/meta.dart';
import 'package:notes/database_tables_models/notes.dart';
import 'package:notes/models/models.dart';
import 'package:notes/router/constants.dart';
import 'package:notes/views/note_detail_view.dart';

class NotesGridView extends StatelessWidget {
  final NotesLoaded state;

  NotesGridView({@required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
          padding: EdgeInsets.all(15.00),
          physics: BouncingScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15.00,
          mainAxisSpacing: 15.00,
          scrollDirection: Axis.vertical,
          children: List.generate(state.notes.length, (index) {
            return Material(
              animationDuration: Duration(seconds: 1),
              color: index.isEven ? Theme.of(context).primaryColorDark.withOpacity(0.5) : Theme.of(context).primaryColorLight.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.00)),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(5.00)),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.7,
                      height: MediaQuery.of(context).size.height / 3,
                      padding: EdgeInsets.all(10.00),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.00))),
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
                                  child: Text(
                                      "${state.notes[index].title}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.00
                                      ),
                                      overflow: TextOverflow.ellipsis
                                  )
                              )
                          ),
                          const SizedBox(height: 5.00),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "${state.notes[index].content}",
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 18.00
                                      ),
                                      overflow: TextOverflow.clip
                                  )
                              )
                          ),
                          const SizedBox(height: 5.00),
                          Container(
                              child: Text(
                                DateFormat("dd MMM hh:mm a").format(DateFormat("dd MMM yyyy hh:mm:ss:a").parse(state.notes[index].dateModified)),
                                style: TextStyle(
                                    color: Colors.blueGrey
                                ), overflow: TextOverflow.ellipsis,
                              )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(icon: state.notes[index].favorite == "no" ? Icon( Icons.favorite_border, color: Colors.blueGrey) : Icon(Icons.favorite),  onPressed: () {
                        Notes notes = Notes.updateFavoriteStatus(state.notes[index].id, state.notes[index].favorite == "no" ? "yes" : "no");
                        BlocProvider.of<NotesBloc>(context).add(UpdateFavoriteStatus(notes: notes, columnName: Notes.columnDateModified, order: Order.descending));
                      }),
                    )
                  ],
                ),
                onTap: () {
                  Future.delayed(Duration(milliseconds: 200), (){
                    Notes notes = Notes.forView(state.notes[index].id, state.notes[index].title, state.notes[index].content, state.notes[index].dateTime, state.notes[index].dateModified, index, index.isEven ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight);
                    Navigator.pushNamed(context, RoutePaths.noteDetailsRoute, arguments: notes);
                  });
                },
              ),
            );
          }
          ),
        )
    );
  }
}
