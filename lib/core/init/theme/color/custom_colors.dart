import 'package:flutter/material.dart';

class CustomColors {
  static CustomColors? _instance;
  CustomColors._();
  static CustomColors get instance => _instance ??= CustomColors._();

  BoxShadow containerBoxShadow = BoxShadow(
    color: Colors.grey[100]!,
    blurRadius: 2.0,
    spreadRadius: 0.0,
    offset: const Offset(0, 2.0), // shadow direction: bottom right
  );
  Color coinColor = Colors.yellow;
  Color bottomBarrippleColor = Colors.grey[300]!;
  Color bottomBarhoverColor = Colors.grey[100]!;
  Color tabBackgroundColor = Colors.grey[100]!;
  Color bottomBarColor = Colors.black;
}
