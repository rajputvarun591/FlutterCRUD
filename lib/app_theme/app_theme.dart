import 'package:flutter/material.dart';
import 'package:notes/models/theme_model.dart';

class AppTheme {

  static final String blueTheme = "blueTheme";
  static final String redTheme = "redTheme";
  static final String tealTheme = "tealTheme";
  static final String purpleTheme = "purpleTheme";

  static final ThemeData getBlueTheme = ThemeData(
    primaryColor: Colors.blue,
    primaryColorDark: Colors.orange,
    primaryColorLight: Colors.green,
    cursorColor: Colors.grey,
    buttonColor: Colors.blue[400],
    //iconTheme: IconThemeData(color: Colors.blue),
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
      subtitle1: TextStyle(color: Colors.blueGrey),
      subtitle2: TextStyle(color: Colors.blueGrey, fontSize: 18.00),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Raleway-Medium"
  );

  static final ThemeData getRedTheme = ThemeData(
    primaryColor: Colors.red,
    primaryColorDark: Colors.pink,
    primaryColorLight: Colors.orange,
    cursorColor: Colors.grey,
    buttonColor: Colors.red[400],
      //iconTheme: IconThemeData(color: Colors.red),
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
      subtitle1: TextStyle(color: Colors.blueGrey),
      subtitle2: TextStyle(color: Colors.blueGrey, fontSize: 18.00),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Raleway-Medium"
  );

  static final ThemeData getTealTheme = ThemeData(
    primaryColor: Colors.teal,
    primaryColorDark: Colors.cyan,
    primaryColorLight: Colors.blue,
    cursorColor: Colors.grey,
    buttonColor: Colors.teal[400],
      //iconTheme: IconThemeData(color: Colors.teal),
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
      subtitle1: TextStyle(color: Colors.blueGrey),
      subtitle2: TextStyle(color: Colors.blueGrey, fontSize: 18.00),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Raleway-Medium"
  );

  static final ThemeData getPurpleTheme = ThemeData(
    primaryColor: Colors.deepPurple,
    primaryColorDark: Colors.purple,
    primaryColorLight: Colors.indigoAccent,
    cursorColor: Colors.grey,
    buttonColor: Colors.deepPurple[400],
      //iconTheme: IconThemeData(color: Colors.deepPurple),
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
      subtitle1: TextStyle(color: Colors.blueGrey),
      subtitle2: TextStyle(color: Colors.blueGrey, fontSize: 18.00),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Raleway-Medium"
  );

  static Future<ThemeModel> getTheme(String themeName) async {
    if(themeName == AppTheme.blueTheme) return ThemeModel(themeData: AppTheme.getBlueTheme);
    if(themeName == AppTheme.redTheme) return ThemeModel(themeData: AppTheme.getRedTheme);
    if(themeName == AppTheme.tealTheme) return ThemeModel(themeData: AppTheme.getTealTheme);
    else return ThemeModel(themeData: AppTheme.getPurpleTheme);
  }
}