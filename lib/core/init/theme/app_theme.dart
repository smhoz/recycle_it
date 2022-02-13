import 'package:flutter/material.dart';

class AppTheme {
  static AppTheme? _instance;
  AppTheme._();
  static AppTheme get instance => _instance ??= AppTheme._();

  ThemeData get theme => ThemeData(
        fontFamily: "MontSerrat",
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        cardColor: Colors.white,
        cardTheme: const CardTheme(elevation: 4),
        textTheme: _textTheme(),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF76acb8),
          onPrimary: Colors.grey[100]!,
          secondary: const Color(0xFFfedadc),
        ),
      );

  TextTheme _textTheme() {
    return const TextTheme(
      headline6: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
      headline1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
      headline2: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w700,
      ),
      bodyText1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
