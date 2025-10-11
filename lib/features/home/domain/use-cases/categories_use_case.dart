import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/home/domain/entities/category_entity.dart';
import 'package:e_commerce_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class CategoriesUseCase {
  final HomeRepository repo;

  CategoriesUseCase(this.repo);
  Future<Either<Failure, List<CategoryEntity>>> getCategories() {
    return repo.getCategories();
  }
}
