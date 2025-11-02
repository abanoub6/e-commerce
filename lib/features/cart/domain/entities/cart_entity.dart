import 'package:e_commerce_app/features/cart/domain/entities/cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> cartItems;

  final int totalCartPrice;

  const CartEntity({required this.cartItems, required this.totalCartPrice});
}
