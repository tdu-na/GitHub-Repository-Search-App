import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff616161),
    appBarTheme: AppBarTheme(
      color: Color(0xff757575),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xff616161),
      secondary: Color(0xff757575),
    ),
  );
}