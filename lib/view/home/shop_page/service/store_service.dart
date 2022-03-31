import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/entity_category.dart';
import '../model/shop_item.dart';

class ShopStoreService {
  ShopStoreService._privateConstructor();
  static final ShopStoreService instance = ShopStoreService._privateConstructor();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<dynamic> getItems() async {
    List<EntityCategory> itemCategories = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnopshot = await firebaseFirestore.collection("ShopItems").get();

      for (var element in querySnopshot.docs) {
        final List<Item> items = [];

        var itemDatas = element["items"] as List<dynamic>;
        var categoryName = element["categoryName"] as String;

        for (var element in itemDatas) {
          items.add(Item.fromMap(element));
        }

        itemCategories.add(EntityCategory(categoryName: categoryName, entities: items));
      }
      return itemCategories;
    } on FirebaseException catch (error) {
      return error;
    }
  }
}
