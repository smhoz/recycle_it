import 'package:flutter/material.dart';

class AppTheme {
  static AppTheme? _instance;
  AppTheme._();
  static AppTheme get instance => _instance ??= AppTheme._();

  ThemeData get theme => ThemeData(
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        cardColor: Colors.white,
        bottomAppBarColor: Colors.yellow,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFf34282),
          onPrimary: Color(0xFFf34282),
          secondary: Color(0xFFfedadc),
        ),
      );
}
