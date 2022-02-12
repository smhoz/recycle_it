import 'entity_category.dart';

class Item {
  final String? imageURL;
  final String? title;
  Item({
    this.imageURL,
    this.title,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(imageURL: map["imageURL"], title: map["title"]);
  }
}
