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
        queryParameters: {if (categoryId != null) 'category': categoryId},
      );

      if (response.statusCode != 200 ||
          response.data == null ||
          response.data["data"].isEmpty) {
        throw RemoteExeption("Failed to fetch products");
      }

      return ProductsResponse.fromJson(response.data);
    } catch (exception) {
      if (exception is DioException) {
        final message =
            exception.response?.data?['message'] ??
            exception.message ??
            "Network error, please try again later";
        throw RemoteExeption(message);
      }
      throw RemoteExeption("Unexpected error occurred");
    }
  }
}
