import 'package:e_commerce_app/features/cart/data/models/cart_item.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_entity.dart';

extension CartMapper on CartModel {
  CartEntity get toEntity => CartEntity(
    cartItems: cartItems.map((cartItem) => cartItem.toEntity).toList(),
    totalCartPrice: totalCartPrice,
  );
}

extension CartMappers on CartItem {
  CartItemEntity get toEntity =>
      CartItemEntity(count: count, id: id, productId: productId, price: price);
}
