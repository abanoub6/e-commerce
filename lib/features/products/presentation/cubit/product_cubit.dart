import 'package:e_commerce_app/features/products/domain/use-cases/get_products_use_case.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ProductCubit extends Cubit<ProductStates> {
  final GetProductsUseCase _getProductsUseCase;
  ProductCubit(this._getProductsUseCase) : super(ProductInitialState());

  Future<void> getProducts(String? categoryId) async {
    emit(ProductLoadingState());
    final eitherResult = await _getProductsUseCase(categoryId);
    eitherResult.fold(
      (failure) => emit(ProductErrorState(message: failure.message)),
      (products) => emit(ProductSuccsessState(products: products)),
    );
  }
}
