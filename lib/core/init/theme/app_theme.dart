import 'package:flutter/material.dart';

class AppTheme {
  static AppTheme? _instance;
  AppTheme._();
  static AppTheme get instance => _instance ??= AppTheme._();

  ThemeData get theme => ThemeData(
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        cardColor: Colors.grey.shade200,
        bottomAppBarColor: Colors.yellow,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFf34282),
          onPrimary: const Color(0xFFf34282),
          secondary: const Color(0xFFfedadc),
        ),
      );
}
