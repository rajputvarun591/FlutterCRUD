 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/app_theme/app_theme.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/blocs/theme_bloc/theme_event.dart';
import 'package:notes/models/order.dart';
import 'package:notes/router/constants.dart';
import 'package:notes/router/router.dart';
import 'package:notes/services/services.dart';

import 'blocs/theme_bloc/theme_bloc.dart';
import 'blocs/theme_bloc/theme_state.dart';
import 'database_tables_models/database_tables_models.dart';
import 'views/main_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    RepositoryProvider<NotesService>(
        create: (context){
          return FakeNoteService();
        },
      child: BlocProvider<NotesBloc>(
          create: (context) {
            final NotesService notesService = RepositoryProvider.of<NotesService>(context);
            return NotesBloc(notesService)..add(ShowNotes(notes: null, columnName: Notes.columnDateModified, order: Order.descending));
          },
        child: MyApp(),
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ThemeService>(
      create: (context){
        return FakeThemeService();
      },
      child: BlocProvider<ThemeBloc>(create: (context) {
        return ThemeBloc(RepositoryProvider.of<ThemeService>(context))..add(ChangeTheme(themeName: AppTheme.blueTheme));
      }, child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state){
        if(state is ThemeChanged) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NotePad',
            theme: state.theme.themeData,
            home: HomeScreen(),
            initialRoute: RoutePaths.homeRoute,
            onGenerateRoute: Router.generateRoute,
          );
        }
        return WidgetsApp(
          color: Colors.pinkAccent,
          builder: (context, int){
            return Scaffold(body: Container(alignment: Alignment.center, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue))));
          },
        );
      })),
    );
  }
}

