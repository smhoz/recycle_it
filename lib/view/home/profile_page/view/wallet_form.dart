import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/core/components/text/input_field.dart';

class WalletForm extends StatelessWidget {
  const WalletForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InputField(
          title: "Ad Soyad",
        ),
        InputField(
          title: "Kart Numarası",
        ),
        InputField(
          textInputType: TextInputType.number,
          title: "Son Kullanım Tarihi",
        ),
        InputField(
          title: "CVV",
          textInputType: TextInputType.number,
        ),
        const _RemeberMyCardSwitch(),
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
            Text("Kartımı hatırla"),
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
