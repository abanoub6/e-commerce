import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/home/data/data-sources/remote-data-source/home_remote_data_source.dart';
import 'package:e_commerce_app/features/home/data/mappers/category_mapper.dart';
import 'package:e_commerce_app/features/home/domain/entities/category_entity.dart';
import 'package:e_commerce_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: HomeRepository)
class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImp(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final response = await homeRemoteDataSource.getCategories();
      final categories = response.categories;
      final categoryEntities =
          categories.map((category) => category.toEntity()).toList();

      return Right(categoryEntities);
    } on RemoteExeption catch (error) {
      return Left(Failure(error.message));
    }
  }
}
