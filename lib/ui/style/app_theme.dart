import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  //Light theme
  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        hintColor: AppColor.blue,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColor.blue, foregroundColor: Colors.white),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black)));
  }
}
