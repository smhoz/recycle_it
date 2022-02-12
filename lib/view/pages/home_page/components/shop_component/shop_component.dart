import 'package:flutter/material.dart';

class ShopComponent extends StatelessWidget {
  const ShopComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Shop Component',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
