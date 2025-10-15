import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';

abstract class ProductStates {}

class ProductInitialState extends ProductStates {}

class ProductLoadingState extends ProductStates {}

class ProductSuccsessState extends ProductStates {
  final List<ProductEntity> products;
  ProductSuccsessState({required this.products});
}

class ProductErrorState extends ProductStates {
  final String message;
  ProductErrorState({required this.message});
}
