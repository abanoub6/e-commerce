import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/cart/data/data-sources/cart_remote_data_source.dart';
import 'package:e_commerce_app/features/cart/data/mappers/cart_mappers.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImp implements CartRepository {
  CartRemoteDataSource dataSource;
  CartRepositoryImp(this.dataSource);
  @override
  Future<Either<Failure, void>> addToCart(String productId) async {
    try {
      await dataSource.addToCart(productId);
    } on RemoteExeption catch (error) {
      return Left(Failure(error.message));
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, CartEntity>> deleteFromCart(String productId) async {
    try {
      final response = await dataSource.deleteFromCart(productId);
      return Right(response.cart.toEntity);
    } on RemoteExeption catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      final response = await dataSource.getCart();
      return Right(response.cart.toEntity);
    } on RemoteExeption catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateCart(
    String productId,
    int quantity,
  ) async {
    try {
      final response = await dataSource.updateCart(productId, quantity);
      return Right(response.cart.toEntity);
    } on RemoteExeption catch (error) {
      return Left(Failure(error.message));
    }
  }
}
