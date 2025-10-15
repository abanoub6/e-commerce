import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/features/products/data/dataSource/remote/remote_products_data_source.dart';
import 'package:e_commerce_app/features/products/data/models/products_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RemoteProductsDataSource)
class RemoteApiProductsDataSource implements RemoteProductsDataSource {
  final Dio dio;

  RemoteApiProductsDataSource(this.dio);
  @override
  Future<ProductsResponse> getProducts(String? categoryId) async {
    try {
      final response = await dio.get(
        ApiConstants.productsEndPoint,
        // send categoryId or not send it if it's null
        queryParameters: {if (categoryId != null) 'category': categoryId},
      );
      return ProductsResponse.fromJson(response.data);
    } on DioException catch (exeption) {
      throw RemoteExeption(exeption.message ?? 'Some thing went wrong');
    }
  }
}
