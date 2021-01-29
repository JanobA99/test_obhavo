import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  bool isDark;


  ThemeNotifier(this._themeData, this.isDark);

  getTheme() => _themeData;

  setTheme(ThemeData themeData, bool isDark) async {
    _themeData = themeData;
    this.isDark =isDark;
    notifyListeners();
  }
}

