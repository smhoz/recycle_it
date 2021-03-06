import 'dart:convert';

enum RecyclableType { paper, plastic, glass, clothes, oil, battery, none }

extension RecyclableName on RecyclableType {
  String get getName => name;
  String getTranslation() {
    switch (this) {
      case RecyclableType.battery:
        return "Battery";
      case RecyclableType.plastic:
        return "Plastic";
      case RecyclableType.glass:
        return "Glass";
      case RecyclableType.clothes:
        return "Kıyafet";
      case RecyclableType.oil:
        return "Oil";
      case RecyclableType.paper:
        return "Paper";
      default:
        return "Yok";
    }
  }
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

  factory Recyclable.fromJson(String source) => Recyclable.fromMap(json.decode(source));

  static RecyclableType fromString(String value) {
    for (var type in RecyclableType.values) {
      if (type.getName == value) return type;
    }
    return RecyclableType.none;
  }
}
