import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/app_theme/app_theme.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/models/order.dart';
import 'package:notes/router/constants.dart';
import 'package:notes/router/router.dart';
import 'package:notes/services/services.dart';

import 'database_tables_models/database_tables_models.dart';
import 'views/main_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      BlocProvider<NotesBloc>(
          create: (context) =>NotesBloc(NoteServiceImpl())
            ..add(ShowNotes(sortBy: Notes.columnDateModified, orderBy: Order.descending)),
          child: MyApp()
      ));
  }

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(create: (context) {
      return ThemeBloc(FakeThemeService())..add(ChangeTheme(themeName: AppTheme.blueTheme));
    }, child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      if (state is ThemeChanged) {
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
        builder: (context, int) {
          return Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue))));
        },
      );
    }));
  }
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotePad',
      theme: AppTheme.getRedTheme,
      home: HomeScreen(),
      initialRoute: RoutePaths.homeRoute,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
