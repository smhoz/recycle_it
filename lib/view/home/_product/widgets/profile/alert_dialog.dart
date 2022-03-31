import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../core/commons/_print_message.dart';

import '../../../../../../../core/utils/locator_get_it.dart';
import '../../../profile_page/viewmodel/cubit/balance_cubit.dart';

class WalletAlertDialog {
  static Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Are you sure ?"),
              ],
            ),
          ),
          actions: <Widget>[
            _cancelButton(context),
            _approveButton(context),
          ],
        );
      },
    );
  }

  static TextButton _cancelButton(BuildContext context) {
    return TextButton(
      child: const Text('Cancel'),
      onPressed: () {
        context.router.pop();
      },
    );
  }

  static TextButton _approveButton(BuildContext context) {
    return TextButton(
      child: const Text('Approve'),
      onPressed: () {
        getIt<BalanceCubit>().balanceUpdate();
        context.router.pop();
        context.router.pop();
        PrintMessage.showSucces(context, message: "Bakiye yükleme başarılı!");
      },
    );
  }
}
