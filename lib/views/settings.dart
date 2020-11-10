import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/app_theme/app_theme.dart';
import 'package:notes/services/theme_service.dart';

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
        child: Text(""),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

