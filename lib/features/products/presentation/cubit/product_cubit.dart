import 'package:e_commerce_app/features/products/domain/use-cases/get_products.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  final GetProducts getProducts;
  ProductCubit(this.getProducts) : super(ProductInitialState());

  Future<void> fetchProducts(String? categoryId) async {
    emit(ProductLoadingState());
    final eitherResult = await getProducts(categoryId);
    eitherResult.fold(
      (failure) => emit(ProductErrorState(message: failure.message)),
      (products) => emit(ProductSuccsessState(products: products)),
    );
  }
}
