import 'package:e_commerce_app/features/products/data/models/products_response.dart';

abstract class RemoteProductsDataSource {
  Future<ProductsResponse> getProducts(String? categoryId);
}
