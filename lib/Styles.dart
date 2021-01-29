import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme,) {
    return ThemeData(
      primarySwatch: null,
      scaffoldBackgroundColor: isDarkTheme ? Color(0xff334055) : Color(0xffF3F5F8),
      primaryColor: isDarkTheme ? Color(0xffffffff) : Color(0xff0065e0),
      backgroundColor: isDarkTheme ? Color(0xff000000) : Color(0xffffffff),
      textSelectionColor: isDarkTheme ? Color(0xffffffff) : Color(0xff757575),
      cardColor: isDarkTheme ? Color(0xffffffff) : Color(0xff000000),
      shadowColor: isDarkTheme ? Color(0x99001a48) : Color(0x00fffffff),
      appBarTheme: AppBarTheme(
        brightness:isDarkTheme ? Brightness.dark :  Brightness.light,
        elevation: 0.0,
      ),
    );
  }
}
