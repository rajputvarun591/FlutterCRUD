import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/enums/enums.dart';
import 'package:notes/models/theme_model.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    primaryColorLight: Color(0xFFa6a6a6),
    primaryColor: Color(0xFF666666),
    primaryColorDark: Color(0xFF262626),
    scaffoldBackgroundColor: const Color(0xFF333333),
    backgroundColor: const Color(0xFF4d4d4d),
    dividerColor: Color(0xFFe6e6e6),
    appBarTheme: AppBarTheme(
      color: const Color(0xFF333333),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: const Color(0xFF333333),
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Color(0xFFe6e6e6)),
      headline2: TextStyle(color: Color(0xFFe6e6e6)),
      headline3: TextStyle(color: Color(0xFFe6e6e6)),
      headline4: TextStyle(color: Color(0xFFe6e6e6)),
      headline5: TextStyle(color: Color(0xFFe6e6e6)),
      headline6: TextStyle(color: Color(0xFFe6e6e6)),
      bodyText1: TextStyle(color: Color(0xFFe6e6e6)),
      subtitle1: TextStyle(color: Color(0xFFe6e6e6)),
    ),
    cardColor: const Color(0xFF4d4d4d),
    iconTheme: const IconThemeData(
      color: Color(0xFFe6e6e6),
      opacity: 7.0,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Color(0xFFe6e6e6),
    ),
    fontFamily: "Raleway-Medium",
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF4d4d4d),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4d4d4d)),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: Color(0xFFe6e6e6),
          ),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF4d4d4d),
      elevation: 0.0,
      actionTextColor: const Color(0xFF4d4d4d),
      contentTextStyle: TextStyle(
        color: const Color(0xFF4d4d4d),
      ),
    ),
  );

  static final ThemeData getBlueTheme = ThemeData(
    primaryColorLight: Colors.blue.shade200,
    primaryColor: Colors.blue,
    primaryColorDark: Colors.blue.shade800,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    dividerColor: Color(0xFFe6e6e6),
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Color(0xFF1a1a1a)),
      headline2: TextStyle(color: Color(0xFF1a1a1a)),
      headline3: TextStyle(color: Color(0xFF1a1a1a)),
      headline4: TextStyle(color: Color(0xFF1a1a1a)),
      headline5: TextStyle(color: Color(0xFF1a1a1a)),
      headline6: TextStyle(color: Color(0xFF1a1a1a)),
      bodyText1: TextStyle(color: Color(0xFF1a1a1a)),
      subtitle1: TextStyle(color: Color(0xFF1a1a1a)),
    ),
    cardColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Color(0xFF1a1a1a),
      opacity: 7.0,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Color(0xFF1a1a1a),
    ),
    fontFamily: "Raleway-Medium",
  );

  static ThemeModel getTheme(ThemeEnum themeName) {
    if (themeName == ThemeEnum.BLUE)
      return ThemeModel(themeData: AppTheme.getBlueTheme);
    else
      return ThemeModel(themeData: AppTheme.darkTheme);
  }
}
