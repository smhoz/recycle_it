import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/core/model/recyclable_model.dart';

class Conversion {
  RecyclableType? type;
  double? weight;
  double? convertedMoneyAmount;
  DateTime? conversionTime;

  Conversion(
      {this.type, this.weight, this.convertedMoneyAmount, this.conversionTime});

  Map<String, dynamic> toMap() {
    return {
      'type': type.toString(),
      'weight': weight,
      'convertedMoneyAmount': convertedMoneyAmount,
      'conversionTime': conversionTime,
    };
  }

  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      type: Recyclable.fromString(map['type']),
      weight: map['weight'] as double,
      convertedMoneyAmount: map['convertedMoneyAmount'] as double,
      conversionTime: (map["conversionTime"] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversion.fromJson(String source) =>
      Conversion.fromMap(json.decode(source));
}
