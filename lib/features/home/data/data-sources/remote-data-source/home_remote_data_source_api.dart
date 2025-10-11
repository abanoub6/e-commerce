import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/features/home/data/data-sources/remote-data-source/home_remote_data_source.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceApi implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceApi(this.dio);
  @override
  Future<CategoriesResponse> getCategories() async {
    try {
      final response = await dio.get(ApiConstants.categoriesEndPoint);
      return CategoriesResponse.fromJson(response.data);
    } on DioException catch (error) {
      throw RemoteExeption(error.message ?? 'Some thing went wrong');
    }
  }
}
