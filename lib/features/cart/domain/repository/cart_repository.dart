import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart(String productId);
  Future<Either<Failure, CartEntity>> updateCart(
    String productId,
    int quantity,
  );
  Future<Either<Failure, CartEntity>> deleteFromCart(String productId);
  Future<Either<Failure, CartEntity>> getCart();
}
