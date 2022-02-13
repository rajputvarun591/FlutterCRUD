import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:meta/meta.dart';
import 'package:notes/database_tables_models/notes.dart';
import 'package:notes/router/constants.dart';

import 'date_widget.dart';

class NotesGridView extends StatefulWidget {
  final NotesLoaded state;

  NotesGridView({@required this.state});

  @override
  _NotesGridViewState createState() => _NotesGridViewState();
}

class _NotesGridViewState extends State<NotesGridView> {
  ScrollController _scrollController;

  NotesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _bloc = BlocProvider.of<NotesBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.state.notes.isEmpty) {
      return _zeroNotesFound(context);
    } else {
      return ListView.builder(
        itemCount: widget.state.notes.length,
        padding: const EdgeInsets.all(10.00),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DateWidget(
                  index: index,
                  notes: widget.state.notes,
                ),
                ListTile(
                  title: Hero(
                    tag: widget.state.notes[index].id,
                    transitionOnUserGestures: true,
                    flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                      return DefaultTextStyle(style: DefaultTextStyle.of(toHeroContext).style, child: toHeroContext.widget);
                    },
                    child: Text(
                      "${widget.state.notes[index].title}",
                      style: theme.textTheme.headline6.copyWith(fontSize: 17.00),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.state.notes[index].content}",
                        style: theme.textTheme.headline6.copyWith(fontSize: 16.00),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      Text(
                        MaterialLocalizations.of(context).formatShortDate(DateTime.parse(widget.state.notes[index].dateModified)),
                        style: theme.textTheme.headline6.copyWith(fontSize: 15.00),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  trailing: IconButton(
                      icon: widget.state.notes[index].favorite == "no"
                          ? Icon(Icons.favorite_border)
                          : Icon(Icons.favorite),
                      onPressed: () {
                        Notes notes =
                            Notes.updateFavoriteStatus(widget.state.notes[index].id, widget.state.notes[index].favorite == "no" ? "yes" : "no");
                        _bloc.add(UpdateFavoriteStatus(notes: notes));
                      }),
                  onTap: () => _onTap(widget.state.notes[index]),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      _bloc.add(ShowNotes(sortBy: widget.state.sortBy, orderBy: widget.state.orderBy, offSet: widget.state.notes.length, limit: 8));
    }
  }

  Widget _zeroNotesFound(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.style, size: 50.00),
            SizedBox(height: 15.00),
            Text("Empty Notes! Add Some.", style: Theme.of(context).textTheme.headline5),
          ],
        ));
  }

  void _onTap(Notes not) async {
    Notes notes = Notes.forView(not.id, not.title, not.content, not.dateTime, not.dateModified);
    int result = await Navigator.pushNamed(context, RoutePaths.noteDetailsRoute, arguments: notes);
    if (result == 1) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Moved To Trash !"),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          strokeWidth: 1.5,
        ),
      ),
    );
  }
}
