import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/app_theme/app_theme.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/blocs/themes/theme_repository.dart';
import 'package:notes/blocs/themes/themes.dart';
import 'package:notes/enums/enums.dart';
import 'package:notes/models/order.dart';
import 'package:notes/router/constants.dart';
import 'package:notes/router/router.dart' as nav;

import 'database_tables_models/database_tables_models.dart';
import 'views/main_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(repository: ThemeRepositoryImpl())
            ..add(
              ChangeTheme(themeName: ThemeEnum.BLUE),
            ),
        ),
        BlocProvider<NotesBloc>(
          create: (context) => NotesBloc(repository: NotesRepositoryImpl())
            ..add(
              ShowNotes(
                sortBy: Notes.columnDateModified,
                orderBy: Order.descending,
              ),
            ),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemesState>(
      cubit: BlocProvider.of<ThemeBloc>(context),
        builder: (context, state) {
      if (state is ThemeChanged) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NotePad',
          theme: state.theme.themeData,
          home: HomeScreen(),
          initialRoute: RoutePaths.homeRoute,
          onGenerateRoute: nav.Router.generateRoute,
        );
      }
      return WidgetsApp(
        color: Colors.pinkAccent,
        builder: (context, int) {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
          );
        },
      );
    });
  }
}
