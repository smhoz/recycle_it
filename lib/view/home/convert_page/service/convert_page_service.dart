import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/model/conversion_model.dart';

class ConvertPageService {
  ConvertPageService._privateConstructor();
  static final ConvertPageService instance =
      ConvertPageService._privateConstructor();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<dynamic> getItems() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection("Conversions")
              .doc("prpPm0VdMol9yS6VPFAm")
              .get();
      Conversion _conversion = Conversion.fromMap(querySnapshot.data()!);
      return _conversion;
    } on FirebaseException catch (error) {
      return error;
    }
  }
}
