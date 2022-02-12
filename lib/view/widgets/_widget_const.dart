import 'package:flutter/material.dart';

class WC {
  static const Widget tpDivider = Divider(color: Colors.transparent);

  static Padding paddingAll({double? val, required Widget child})  => Padding(
        padding:  EdgeInsets.all(val ?? 8), child: child);
}
