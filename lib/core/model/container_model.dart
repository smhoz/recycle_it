import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'recyclable_model.dart';

class RecycleContainer {
  String? name;
  LatLng? location; //TODO: Convert this data type to GeoPoint
  String? address;
  List<Recyclable>? recyclables;

  RecycleContainer({this.name, this.location, this.recyclables, this.address});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'address': address,
      'recyclables': recyclables,
    };
  }

  factory RecycleContainer.fromMap(Map<String, dynamic> map) {
    return RecycleContainer(
      name: map['name'],
      location: map['location'],
      address: map['address'],
      recyclables: map['recyclables'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecycleContainer.fromJson(String source) =>
      RecycleContainer.fromMap(json.decode(source));
}
