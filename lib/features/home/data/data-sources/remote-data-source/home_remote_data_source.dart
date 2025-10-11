import 'package:e_commerce_app/features/home/data/models/categories_response.dart';

abstract class HomeRemoteDataSource {
  Future<CategoriesResponse> getCategories();
}
