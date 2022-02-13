import 'dart:convert';

enum RecyclableType { paper, plastic, glass, clothes, oil, battery }

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
      type: map['type'],
      currentLoad: map['currentLoad'],
      maxLoad: map['maxLoad'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Recyclable.fromJson(String source) =>
      Recyclable.fromMap(json.decode(source));
}
