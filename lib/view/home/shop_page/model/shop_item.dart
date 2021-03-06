class Item {
  final String? imageURL;
  final String? title;
  final String? description;
  final double? price;
  Item({
    this.imageURL,
    this.title,
    this.price,
    this.description,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    var price = map["price"];
    if (price is int) {
      price = (map['price'] as int).toDouble();
    }

    return Item(
      imageURL: map['imageURL'],
      title: map['title'],
      price: price,
      description: map['description'],
    );
  }
}
