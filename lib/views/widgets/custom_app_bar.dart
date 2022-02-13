import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/database_helper/database_helper.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/views/custom_popup_menu_button/custom_popup_menu_button.dart';
import 'package:notes/views/search_notes/search_notes.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Animation<double> progress;
  final AnimationController animationController;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  CustomAppBar({@required this.progress, @required this.animationController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Notes"),
      actions: <Widget>[
        /*IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.view_list,
              progress: progress,
            ),
            onPressed: () {
              if(animationController.value == 1.0) {
                animationController.reverse();
              } else {
                animationController.forward();
              }
            }),*/
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            List<Notes> list = await _databaseHelper.getAllNotes();
            await showSearch<Notes>(
              context: context,
              delegate: SearchNotes(
                bloc: BlocProvider.of<NotesBloc>(context),
                list: list,
              ),
            );
          },
        ),
        CustomPopupMenuButton()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
