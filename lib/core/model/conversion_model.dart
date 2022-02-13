import 'dart:convert';

import 'package:hackathon_app/core/model/container_model.dart';
import 'package:hackathon_app/core/model/recyclable_model.dart';

class Conversion {
  RecycleContainer? container;
  RecyclableType? type;
  double? weight;
  double? convertedMoneyAmount;
  DateTime? conversionTime;

  Conversion(
      {this.container,
      this.type,
      this.weight,
      this.convertedMoneyAmount,
      this.conversionTime});

  Map<String, dynamic> toMap() {
    return {
      'container': container,
      'type': type,
      'weight': weight,
      'convertedMoneyAmount': convertedMoneyAmount,
      'conversionTime': conversionTime,
    };
  }

  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      container: map['container'],
      type: map['type'],
      weight: map['weight'],
      convertedMoneyAmount: map['convertedMoneyAmount'],
      conversionTime: map['conversionTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversion.fromJson(String source) =>
      Conversion.fromMap(json.decode(source));
}
