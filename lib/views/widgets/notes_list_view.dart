import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/database_tables_models/notes.dart';
import 'package:notes/models/models.dart';
import 'package:notes/router/constants.dart';
import 'package:notes/views/note_detail_view.dart';

class NotesListView extends StatelessWidget {
  final NotesLoaded state;

  NotesListView({@required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          padding: EdgeInsets.all(15.00),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Material(
              color: index.isEven
                  ? Theme.of(context).primaryColorDark.withOpacity(0.5)
                  : Theme.of(context).primaryColorLight.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.00)),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(5.00)),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.00),
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
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
                                  child: Text("${state.notes[index].title}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.00
                                      )
                                  )
                              )
                          ),
                          Container(
                              child: Text(
                                "${state.notes[index].content}",
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
                                          .parse(state.notes[index].dateModified)),
                                  style: TextStyle(color: Colors.blueGrey
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(icon: state.notes[index].favorite == "no" ? Icon( Icons.favorite_border, color: Colors.blueGrey,) : Icon(Icons.favorite),  onPressed: () {
                        Notes notes = Notes.updateFavoriteStatus(state.notes[index].id, state.notes[index].favorite == "no" ? "yes" : "no");
                        BlocProvider.of<NotesBloc>(context).add(UpdateFavoriteStatus(notes: notes, columnName: Notes.columnDateModified, order: Order.descending));
                      }),
                    )
                  ],
                ),
                onTap: () async{
                  Notes notes = Notes.forView(state.notes[index].id, state.notes[index].title, state.notes[index].content, state.notes[index].dateTime, state.notes[index].dateModified, index, index.isEven ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight);
                  await Navigator.pushNamed(context, RoutePaths.noteDetailsRoute, arguments: notes);
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10.00);
          },
          itemCount: state.notes.length
      ),
    );
  }
}
