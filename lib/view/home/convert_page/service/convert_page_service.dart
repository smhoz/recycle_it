import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/core/model/conversion_model.dart';

class ConvertPageService {
  ConvertPageService._privateConstructor();
  static final ConvertPageService instance =
      ConvertPageService._privateConstructor();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<dynamic> getItems(String? id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection("Conversions").doc(id!).get();
      Conversion _conversion = Conversion.fromMap(querySnapshot.data()!);
      return _conversion;
    } on FirebaseException catch (error) {
      return error;
    }
  }
}
