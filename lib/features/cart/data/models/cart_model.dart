import 'package:e_commerce_app/features/cart/data/models/cart_item.dart';

class CartModel {
  final String id;
  final String cartOwner;
  final List<CartItem> cartItems;
  final DateTime createdAt;
  final DateTime updatedAt;

  final int totalCartPrice;

  const CartModel({
    required this.id,
    required this.cartOwner,
    required this.cartItems,
    required this.createdAt,
    required this.updatedAt,

    required this.totalCartPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['_id'] as String,
    cartOwner: json['cartOwner'] as String,
    cartItems:
        (json['products'] as List<dynamic>)
            .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList(),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),

    totalCartPrice: json['totalCartPrice'] as int,
  );
}
