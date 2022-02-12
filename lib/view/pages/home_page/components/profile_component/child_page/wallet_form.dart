import 'package:flutter/material.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/utils/locator_get_it.dart';
import 'package:hackathon_app/view/pages/home_page/components/profile_component/child_page/cubit/balance_cubit.dart';
import 'package:hackathon_app/view/widgets/_custom_text_field.dart';
import 'package:hackathon_app/view/widgets/_widget_const.dart';

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
          WC.tpDivider,
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
          WC.tpDivider,
          CustomTextFormField(
            controller: _cubit.cardHoldersNameController,
            labelText: 'Cardholder\'s name',
          ),
          WC.tpDivider,
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
