import 'package:flutter/material.dart';

class MapComponet extends StatelessWidget {
  const MapComponet({Key? key}) : super(key: key);

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
