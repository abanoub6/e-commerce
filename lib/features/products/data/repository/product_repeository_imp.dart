import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/products/data/dataSource/remote/remote_products_data_source.dart';
import 'package:e_commerce_app/features/products/data/mappers/product_mapper.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/products/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepeositoryImp implements ProductRepository {
  final RemoteProductsDataSource _remoteProductsDataSource;

  ProductRepeositoryImp(this._remoteProductsDataSource);
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    String? categoryId,
  ) async {
    try {
      final productsResponse = await _remoteProductsDataSource.getProducts(
        categoryId,
      );
      final List<ProductEntity> products =
          (productsResponse.products)
              .map((product) => product.toEntity())
              .toList();
      return Right(products);
    } catch (failure) {
      return Left(Failure(failure.toString()));
    }
  }
}
