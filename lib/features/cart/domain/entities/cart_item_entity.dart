import 'package:e_commerce_app/features/cart/domain/entities/product_cart_entity.dart';

class CartItemEntity {
  final int count;
  final String? id;
  final ProductCartEntity product;
  final double price;

  const CartItemEntity({
    required this.count,
    this.id,
    required this.product,
    required this.price,
  });
}
