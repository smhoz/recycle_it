import 'package:flutter/material.dart';

class CustomBorderRadius extends BorderRadius {
  CustomBorderRadius.veryLowCircular() : super.circular(4);
  CustomBorderRadius.lowCircular() : super.circular(8);
  CustomBorderRadius.normalCircular() : super.circular(16);

  const CustomBorderRadius.onlyTopLeftAndRightNormalCircular() : super.only(topLeft: const Radius.circular(16), topRight: const Radius.circular(16));
  const CustomBorderRadius.onlyBottomLeftAndRightNormalCircular()
      : super.only(bottomLeft: const Radius.circular(16), bottomRight: const Radius.circular(16));

  CustomBorderRadius.highCircular() : super.circular(100);
}
