import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  //Light theme
  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        hintColor: AppColor.green,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColor.green, foregroundColor: Colors.white),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black)));
  }

  //dark theme
  static ThemeData get darkTheme {
    return ThemeData(
        scaffoldBackgroundColor: AppColor.heavyGrey,
        hintColor: AppColor.green,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColor.green, foregroundColor: Colors.white),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black)));
  }
}
