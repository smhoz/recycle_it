import 'package:flutter/material.dart';
import 'package:hackathon_app/core/commons/_print_message.dart';

import '../../../../../../../core/utils/locator_get_it.dart';
import '../../viewmodel/cubit/balance_cubit.dart';

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
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                getIt<BalanceCubit>().balanceUpdate();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                PrintMessage.showSucces(context,
                    message: "Bakiye yükleme başarılı!");
              },
            ),
          ],
        );
      },
    );
  }
}
