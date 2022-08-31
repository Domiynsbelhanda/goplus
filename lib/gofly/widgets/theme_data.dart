import 'package:flutter/material.dart';
import 'package:goplus/gofly/utils/app_colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    // Define the default brightness and colors.
    primaryColor: AppColors.primaryColor,
    accentColor: Colors.cyan[600],
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      centerTitle: true,
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    ),
  );
}
