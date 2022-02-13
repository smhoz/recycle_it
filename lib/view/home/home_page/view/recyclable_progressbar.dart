import 'package:flutter/material.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/model/recyclable_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RecyclableProgressBar extends StatelessWidget {
  final Recyclable? recyclable;
  const RecyclableProgressBar({Key? key, this.recyclable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percent = recyclable!.currentLoad! / recyclable!.maxLoad!;
    return Padding(
      padding: context.paddingLow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            recyclable!.type!.getName,
            style: context.textTheme.bodyMedium!.copyWith(fontSize: 18),
          ),
          Padding(
            padding: context.paddingHorizontalMedium,
            child: _circularPercentIndicator(percent, context),
          ),
        ],
      ),
    );
  }

  CircularPercentIndicator _circularPercentIndicator(
      double percent, BuildContext context) {
    return CircularPercentIndicator(
      radius: 28.0,
      lineWidth: 4.0,
      percent: percent,
      progressColor: context.themeColor.secondary,
      center: Text(
        "%" + (percent * 100).toInt().toString(),
        style: context.textTheme.bodyText1!.copyWith(fontSize: 14),
      ),
    );
  }
}
