import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

class PrintMessage {
  static ScaffoldFeatureController showFailed(BuildContext context, {String? message}) {
    final _failed = SnackBar(
      padding: context.paddingMedium,
      content: Text(message ?? 'Something went wrong.'),
      backgroundColor: context.themeColor.onError,
    );
    return ScaffoldMessenger.of(context).showSnackBar(_failed);
  }

  static ScaffoldFeatureController showSucces(BuildContext context, {String? message}) {
    final _success = SnackBar(
      duration: context.snackBarDuration,
      padding: context.paddingMedium,
      content: Text(message ?? 'Successful'),
      backgroundColor: context.themeColor.secondary,
    );
    return ScaffoldMessenger.of(context).showSnackBar(_success);
  }
}
