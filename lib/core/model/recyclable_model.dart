import 'dart:convert';

enum RecyclableType { paper, plastic, glass, clothes, oil, battery, none }

extension RecyclableName on RecyclableType {
  String get getName => name;
}

class Recyclable {
  RecyclableType? type;
  double? currentLoad;
  double? maxLoad;

  Recyclable({
    this.type,
    this.currentLoad,
    this.maxLoad,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'currentLoad': currentLoad,
      'maxLoad': maxLoad,
    };
  }

  factory Recyclable.fromMap(Map<String, dynamic> map) {
    return Recyclable(
      type: Recyclable.fromString(map['type']),
      currentLoad: map['currentLoad'] as double?,
      maxLoad: map['maxLoad'] as double?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recyclable.fromJson(String source) =>
      Recyclable.fromMap(json.decode(source));

  static RecyclableType fromString(String value) {
    for (var type in RecyclableType.values) {
      if (type.getName == value) return type;
    }
    return RecyclableType.none;
  }
}
