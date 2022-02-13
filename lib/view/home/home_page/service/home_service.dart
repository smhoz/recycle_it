import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/model/container_model.dart';
import '../../../../core/model/recyclable_model.dart';

class HomeStoreService {
  HomeStoreService._privateConstructor();
  static final HomeStoreService instance =
      HomeStoreService._privateConstructor();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<dynamic> getContainers() async {
    List<RecycleContainer> containers = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnopshot =
          await firebaseFirestore.collection("Containers").get();

      for (var element in querySnopshot.docs) {
        final List<Recyclable> items = [];

        var itemDatas = element["recyclables"] as List<dynamic>;
        var address = element["address"] as String;
        var geoPoint = element["location"] as GeoPoint;
        var name = element["name"] as String;

        var location = LatLng(geoPoint.latitude, geoPoint.longitude);
        for (var element in itemDatas) {
          items.add(Recyclable.fromMap(element));
        }

        containers.add(RecycleContainer(
            address: address,
            location: location,
            name: name,
            recyclables: items));
      }
      return containers;
    } on FirebaseException catch (error) {
      return error;
    }
  }

  void updateContainer(
    String docID,
    Recyclable recyclable,
  ) {
    firebaseFirestore.collection("Containers").doc(docID).update({
      "recyclables": FieldValue.arrayUnion([recyclable.toMap()]),
    });
  }
}
