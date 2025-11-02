import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/products/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);
  Future<Either<Failure, List<ProductEntity>>> call(String? categoryId) async {
    return await repository.getProducts(categoryId);
  }
}
