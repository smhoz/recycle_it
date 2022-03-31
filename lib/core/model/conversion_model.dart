import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'recyclable_model.dart';

class Conversion {
  final String? containerID;
  final RecyclableType? type;
  final double? weight;
  final double? convertedMoneyAmount;
  final DateTime? conversionTime;

  const Conversion(
      {this.type,
      this.weight,
      this.convertedMoneyAmount,
      this.conversionTime,
      this.containerID});

  Map<String, dynamic> toMap() {
    return {
      'type': type.toString(),
      'weight': weight,
      'convertedMoneyAmount': convertedMoneyAmount,
      'conversionTime': conversionTime,
      "containerID": containerID,
    };
  }

  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      type: Recyclable.fromString(map['type']),
      weight: map['weight'] as double,
      containerID: map["containerID"],
      convertedMoneyAmount: map['convertedMoneyAmount'] as double,
      conversionTime: (map["conversionTime"] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversion.fromJson(String source) =>
      Conversion.fromMap(json.decode(source));
}
