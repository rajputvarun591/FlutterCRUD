import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:meta/meta.dart';
import 'package:notes/database_tables_models/notes.dart';
import 'package:notes/models/models.dart';
import 'package:notes/router/constants.dart';

class NotesGridView extends StatefulWidget {
  final NotesLoaded state;

  NotesGridView({@required this.state});

  @override
  _NotesGridViewState createState() => _NotesGridViewState();
}

class _NotesGridViewState extends State<NotesGridView> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<Offset> _animation;


  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<Offset>(begin: Offset(0.0, 3.0), end: Offset.zero).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut));
    super.initState();
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
        child: GridView.count(
          padding: EdgeInsets.all(15.00),
          physics: BouncingScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15.00,
          mainAxisSpacing: 15.00,
          scrollDirection: Axis.vertical,
          children: List.generate(widget.state.notes.length, (index) {
            _animationController.forward();
            return SlideTransition(
              position: _animation,
              transformHitTests: true,
              child: Material(
                animationDuration: Duration(seconds: 1),
                color: index.isEven
                    ? theme.primaryColorDark.withOpacity(0.5)
                    : theme.primaryColorLight.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(5.00)),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(5.00)),
                  child: Stack(
                    children: [
                      Container(
                        width: mediaQuery.width / 2.7,
                        height: mediaQuery.height / 3,
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
                                        "${widget.state.notes[index].title}",
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
                                        "${widget.state.notes[index].content}",
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
                                  DateFormat("dd MMM hh:mm a").format(DateFormat("dd MMM yyyy hh:mm:ss:a").parse(widget.state.notes[index].dateModified)),
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
                        child: IconButton(icon: widget.state.notes[index].favorite == "no" ? Icon( Icons.favorite_border, color: Colors.blueGrey) : Icon(Icons.favorite),  onPressed: () {
                          Notes notes = Notes.updateFavoriteStatus(widget.state.notes[index].id, widget.state.notes[index].favorite == "no" ? "yes" : "no");
                          BlocProvider.of<NotesBloc>(context).add(UpdateFavoriteStatus(notes: notes, columnName: Notes.columnDateModified, order: Order.descending));
                        }),
                      )
                    ],
                  ),
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 200), (){
                      Notes notes = Notes.forView(
                          widget.state.notes[index].id,
                          widget.state.notes[index].title,
                          widget.state.notes[index].content,
                          widget.state.notes[index].dateTime,
                          widget.state.notes[index].dateModified,
                          index,
                          index.isEven
                              ? theme.primaryColorDark
                              : theme.primaryColorLight);
                      Navigator.pushNamed(context, RoutePaths.noteDetailsRoute, arguments: notes);
                    });
                  },
                  onDoubleTap: (){},
                ),
              ),
            );
          }
          ),
        )
    );
  }
}
