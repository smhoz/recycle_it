import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../consts/app/app_constant.dart';

class AppTheme {
  static AppTheme? _instance;
  AppTheme._();
  static AppTheme get instance => _instance ??= AppTheme._();

  ThemeData get theme => ThemeData(
        fontFamily: AppConstant.FONT_FAMILY,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white, size: 24), titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
        cardColor: Colors.white,
        cardTheme: const CardTheme(elevation: 4),
        textTheme: _textTheme(),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF76acb8),
          onPrimary: Colors.grey[100]!,
          onSecondary: Colors.black,
          secondary: Colors.green,
          onError: Colors.red,
          secondaryContainer: Colors.grey.shade100,
        ),
      );

  TextTheme _textTheme() {
    return const TextTheme(
      headline1: TextStyle(letterSpacing: 3, fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
      headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
      headline4: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
      headline6: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
      bodyText1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }
}
