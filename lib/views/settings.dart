import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/themes/theme_bloc.dart';
import 'package:notes/blocs/themes/theme_bloc.dart';
import 'package:notes/blocs/themes/theme_bloc.dart';
import 'package:notes/blocs/themes/theme_bloc.dart';
import 'package:notes/blocs/themes/themes_event.dart';
import 'package:notes/blocs/themes/themes_event.dart';
import 'package:notes/blocs/themes/themes_event.dart';
import 'package:notes/blocs/themes/themes_event.dart';
import 'package:notes/enums/enums.dart';
import 'package:notes/enums/enums.dart';
import 'package:notes/enums/enums.dart';
import 'package:notes/enums/enums.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin{
  List<AnimationController> _animationController;
  int index;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Theme"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.00),
        child: Column(
          children: [
            FlatButton.icon(onPressed: (){
              BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(themeName: ThemeEnum.BLUE));
            }, icon: Icon(Icons.color_lens), label: Text("BLUE")),
            FlatButton.icon(onPressed: (){
              BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(themeName: ThemeEnum.RED));
            }, icon: Icon(Icons.color_lens), label: Text("RED")),
            FlatButton.icon(onPressed: (){
              BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(themeName: ThemeEnum.TEAL));
            }, icon: Icon(Icons.color_lens), label: Text("TEAL")),
            FlatButton.icon(onPressed: (){
              BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(themeName: ThemeEnum.PURPLE));
            }, icon: Icon(Icons.color_lens), label: Text("PURPLE")),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

