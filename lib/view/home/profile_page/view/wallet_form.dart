import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/utils/locator_get_it.dart';

import '../../../../core/commons/_custom_text_field.dart';
import '../viewmodel/cubit/balance_cubit.dart';

class WalletForm extends StatelessWidget {
  const WalletForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = getIt<BalanceCubit>();
    return SizedBox(
      width: context.width,
      height: context.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
              controller: _cubit.cardNumberController,
              labelText: 'Card number'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                controller: _cubit.expireDateController,
                labelText: 'Expired date',
              ),
              const VerticalDivider(),
              CustomTextFormField(
                  controller: _cubit.cvvController, labelText: 'CVV'),
            ],
          ),
          CustomTextFormField(
            controller: _cubit.cardHoldersNameController,
            labelText: 'Cardholder\'s name',
          ),
          const _Switch(),
        ],
      ),
    );
  }
}

class _Switch extends StatefulWidget {
  const _Switch({Key? key}) : super(key: key);

  @override
  _SwitchState createState() => _SwitchState();
}

class _SwitchState extends State<_Switch> {
  bool _switchState = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            VerticalDivider(),
            Text(
              "Remember my card.",
            ),
          ],
        ),
        themeSwitch(),
      ],
    );
  }

  Widget themeSwitch() {
    return Switch(
        value: _switchState,
        onChanged: (value) {
          setState(() {
            _switchState = value;
          });
        });
  }
}
