import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/services/services.dart';

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
            return NotesBloc(notesService)..add(ShowNotes(notes: null));
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotePad',
      theme: ThemeData(
        fontFamily: 'Raleway-Medium',
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: <String, WidgetBuilder> {
        '/HomeScreen': (BuildContext context) => new HomeScreen()
      },
    );
  }
}

