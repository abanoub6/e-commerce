import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';

class CartModel {
  final String? id;
  final String? cartOwner;
  final List<CartItemModel> cartItems;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final int totalCartPrice;

  const CartModel({
    this.id,
    this.cartOwner,
    required this.cartItems,
    this.createdAt,
    this.updatedAt,

    required this.totalCartPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['_id'] as String?,
    cartOwner: json['cartOwner'] as String?,
    cartItems:
        (json['products'] as List<dynamic>)
            .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
    createdAt:
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    updatedAt:
        json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,

    totalCartPrice: json['totalCartPrice'] as int,
  );
}
