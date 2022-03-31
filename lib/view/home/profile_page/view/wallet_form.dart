import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/text/input_field.dart';

class WalletForm extends StatelessWidget {
  const WalletForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        InputField(
          title: "Name And Surname ",
        ),
        InputField(
          title: "Card Number",
        ),
        InputField(
          textInputType: TextInputType.number,
          title: "Expiration Date",
        ),
        InputField(
          title: "CVV",
          textInputType: TextInputType.number,
        ),
        _RemeberMyCardSwitch(),
      ],
    );
  }
}

class _RemeberMyCardSwitch extends StatefulWidget {
  const _RemeberMyCardSwitch({Key? key}) : super(key: key);

  @override
  _RemeberMyCardSwitchState createState() => _RemeberMyCardSwitchState();
}

class _RemeberMyCardSwitchState extends State<_RemeberMyCardSwitch> {
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
            Text("Remember"),
          ],
        ),
        themeSwitch(),
      ],
    );
  }

  Widget themeSwitch() {
    return Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
          value: _switchState,
          onChanged: (value) {
            setState(() {
              _switchState = value;
            });
          }),
    );
  }
}
