class Item {
  final String? imageURL;
  final String? title;
  final double? price;
  Item({
    this.imageURL,
    this.title,
    this.price,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    var price=map["price"];
    if (map['price'] is int) {
      price = (map['price'] as int).toDouble();
    }

    return Item(
      imageURL: map['imageURL'],
      title: map['title'],
      price: price,
    );
  }
}
