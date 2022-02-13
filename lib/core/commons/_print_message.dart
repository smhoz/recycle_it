import 'package:flutter/material.dart';

class PrintMessage {
  static ScaffoldFeatureController showFailed(BuildContext context,
      {String? message}) {
    final _failed = SnackBar(
      content: Text(message ?? 'Something went wrong.'),
      backgroundColor: Colors.red,
    );
    return ScaffoldMessenger.of(context).showSnackBar(_failed);
  }

  static ScaffoldFeatureController showSucces(BuildContext context,
      {String? message}) {
    final _success = SnackBar(
      content: Text(message ?? 'Successful'),
      backgroundColor: Colors.green,
    );
    return ScaffoldMessenger.of(context).showSnackBar(_success);
  }
}
