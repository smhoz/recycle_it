import 'package:flutter/material.dart';

class CustomBorderRadius extends BorderRadius {
  CustomBorderRadius.veryLowCircular() : super.circular(4);
  CustomBorderRadius.lowCircular() : super.circular(8);
  CustomBorderRadius.normalCircular() : super.circular(16);

  CustomBorderRadius.highCircular() : super.circular(100);
}
