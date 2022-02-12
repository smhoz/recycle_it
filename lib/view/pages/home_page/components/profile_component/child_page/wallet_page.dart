import 'package:flutter/material.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/view/widgets/_custom_text_field.dart';
import 'package:hackathon_app/view/widgets/_widget_const.dart';
import 'package:hackathon_app/view/widgets/input_field.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IncrementButton(iconName: Icons.remove),
                  Flexible(
                    child: InputField(
                      title: "Amount",
                    ),
                  ),
                  IncrementButton(iconName: Icons.add),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Text(
              "Card Info",
              style: context.textTheme.headline1,
            ),
            _CardForm(),
          ],
        ),
      ),
    );
  }
}

class IncrementButton extends StatelessWidget {
  final IconData iconName;
  const IncrementButton({
    Key? key,
    required this.iconName,
  }) : super(key: key);

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
        onPressed: () {},
        icon: Icon(iconName),
      ),
    );
  }
}

class _CardForm extends StatefulWidget {
  _CardForm({Key? key}) : super(key: key);

  @override
  State<_CardForm> createState() => __CardFormState();
}

class __CardFormState extends State<_CardForm> {
  final _key = GlobalKey<FormState>();
  final _cardController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CustomTextFormField(controller: _cardController)],
    );
  }
}
