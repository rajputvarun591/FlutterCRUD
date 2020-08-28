import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData blueTheme = ThemeData(
    primaryColor: Colors.blue,
    primaryColorDark: Colors.orange,
    primaryColorLight: Colors.green,
    cursorColor: Colors.grey,
    buttonColor: Colors.blue[400],
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
      subtitle1: TextStyle(color: Colors.blueGrey),
      subtitle2: TextStyle(color: Colors.blueGrey, fontSize: 18.00),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Raleway-Medium"
  );

  static final ThemeData redTheme = ThemeData(
    primaryColor: Colors.red,
    primaryColorDark: Colors.pink,
    primaryColorLight: Colors.orange,
    cursorColor: Colors.grey,
    buttonColor: Colors.red[400],
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
      subtitle1: TextStyle(color: Colors.blueGrey),
      subtitle2: TextStyle(color: Colors.blueGrey, fontSize: 18.00),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Raleway-Medium"
  );

  static final ThemeData tealTheme = ThemeData(
    primaryColor: Colors.teal,
    primaryColorDark: Colors.cyan,
    primaryColorLight: Colors.blue,
    cursorColor: Colors.grey,
    buttonColor: Colors.teal[400],
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
      subtitle1: TextStyle(color: Colors.blueGrey),
      subtitle2: TextStyle(color: Colors.blueGrey, fontSize: 18.00),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Raleway-Medium"
  );

  static final ThemeData purpleTheme = ThemeData(
    primaryColor: Colors.deepPurple,
    primaryColorDark: Colors.purple,
    primaryColorLight: Colors.indigoAccent,
    cursorColor: Colors.grey,
    buttonColor: Colors.deepPurple[400],
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
      subtitle1: TextStyle(color: Colors.blueGrey),
      subtitle2: TextStyle(color: Colors.blueGrey, fontSize: 18.00),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Raleway-Medium"
  );
}