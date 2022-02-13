import 'package:flutter/material.dart';
import 'package:hackathon_app/core/model/recyclable_model.dart';

class RecyclableProgressBar extends StatelessWidget {
  final Recyclable? recyclable;
  const RecyclableProgressBar({Key? key, this.recyclable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 16,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Text(recyclable!.type!.getName),
            Text("${recyclable!.currentLoad} / ${recyclable!.maxLoad}"),
          ],
        ),
      ),
    );
  }
}
