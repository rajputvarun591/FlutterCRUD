import 'package:flutter/material.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/router/constants.dart';
import 'package:notes/views/main_view.dart';
import 'package:notes/views/note_detail_view.dart';
import 'package:notes/views/settings.dart';
import 'package:notes/views/trash_bin.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutePaths.homeRoute : return MaterialPageRoute(builder: (_) => HomeScreen());

      case RoutePaths.noteDetailsRoute :
        Notes notes = settings.arguments as Notes;
        return MaterialPageRoute<int>(builder: (_) => NoteDetailView(notes: notes));

      case RoutePaths.settingsRoute :
        return MaterialPageRoute(builder: (_) => Settings());

      case RoutePaths.trashBinRoute :
        List<Notes> trash = settings.arguments as List<Notes>;
        return MaterialPageRoute(builder: (_) => TrashBin(trash: trash));

        default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            )
        );
    }
  }
}