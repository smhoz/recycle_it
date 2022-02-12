import 'package:flutter/material.dart';

class MapComponent extends StatelessWidget {
  const MapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Map Component',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
