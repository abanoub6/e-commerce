import 'package:e_commerce_app/features/cart/data/models/product_cart_model.dart';

class CartItemModel {
  final int count;
  final String? id;
  final ProductCartModel product;
  final double price;

  const CartItemModel({
    required this.count,
    this.id,
    required this.product,
    required this.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    count: json['count'] as int,
    id: json['_id'] as String?,
    product: ProductCartModel.fromJson(json['product'] as Map<String, dynamic>),
    price: (json['price'] as num).toDouble(),
  );
}
