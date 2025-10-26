class CartItem {
  final int? count;
  final String? id;
  final String? productId;
  final int? price;

  const CartItem({this.count, this.id, this.productId, this.price});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    count: json['count'] as int?,
    id: json['_id'] as String?,
    productId: json['product'] as String?,
    price: json['price'] as int?,
  );
}
