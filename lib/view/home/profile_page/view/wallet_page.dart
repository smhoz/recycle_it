import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/core/utils/locator_get_it.dart';
import 'package:hackathon_app/view/home/profile_page/view/wallet_form.dart';

import '../../../widgets/_widget_const.dart';
import 'components/_alert_dialog.dart';
import 'cubit/balance_cubit.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _cubit = getIt<BalanceCubit>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.orange[400],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text("Payment"),
        ),
      ),
      body: BlocProvider(
        create: (context) => _cubit,
        child: ListView(
          children: [
            WC.paddingAll(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _IconButton(
                      iconName: Icons.remove,
                      changeValue: _cubit.balanceDecrement),
                  const _BalanceInput(),
                  _IconButton(
                      iconName: Icons.add,
                      changeValue: _cubit.balanceIncrement),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Card Info",
            ),
            const WalletForm(),
            WC.paddingAll(
                child: ElevatedButton(
                    onPressed: () {
                      WalletAlertDialog.showMyDialog(context);
                    },
                    child: const Text('Submit')))
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData iconName;
  const _IconButton({
    Key? key,
    required Function this.changeValue,
    required this.iconName,
  }) : super(key: key);
  final Function changeValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: IconButton(
        color: Colors.white,
        iconSize: 32,
        onPressed: () => changeValue(),
        icon: Icon(iconName),
      ),
    );
  }
}

class _BalanceInput extends StatelessWidget {
  const _BalanceInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
