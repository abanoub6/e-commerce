import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/data/models/product_cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/features/cart/domain/entities/product_cart_entity.dart';

extension CartMapper on CartModel {
  CartEntity get toEntity => CartEntity(
    cartItems: cartItems.map((cartItem) => cartItem.toEntity).toList(),
    totalCartPrice: totalCartPrice,
  );
}

extension CartItemMapper on CartItemModel {
  CartItemEntity get toEntity => CartItemEntity(
    count: count,
    id: id,
    product: product.toEntity,
    price: price,
  );
}

extension ProductCartMapper on ProductCartModel {
  ProductCartEntity get toEntity => ProductCartEntity(
    id: id,
    title: title,
    quantity: quantity,
    imageCover: imageCover,
  );
}
