import 'package:e_commerce_app/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CartCubit extends Cubit<CartCubitStates> {
  CartEntity? currentCart;
  final CartRepository cartRepository;

  CartCubit(this.cartRepository) : super(CartCubitInitialState());

  Future<void> addToCart(String productId) async {
    emit(CartCubitAddLoadingState());
    final response = await cartRepository.addToCart(productId);
    response.fold(
      (failure) => emit(CartCubitAddErrorState(failure.message)),
      (_) => emit(CartCubitAddSuccessState()),
    );
  }

  Future<void> getCart() async {
    emit(CartCubitGetLoadingState());
    final response = await cartRepository.getCart();
    response.fold((failure) => emit(CartCubitGetErrorState(failure.message)), (
      cart,
    ) {
      currentCart = cart;
      emit(CartCubitGetSuccessState(cart));
    });
  }

  Future<void> updateCartProductQuantity(String productId, int quantity) async {
    emit(CartCubitUpdateLoadingState());
    final response = await cartRepository.updateCart(productId, quantity);
    response.fold(
      (failure) => emit(CartCubitUpdateErrorState(failure.message)),
      (cart) {
        currentCart = cart;
        emit(CartCubitUpdateSuccessState(cart));
      },
    );
  }

  Future<void> deleteFromCart(String productId) async {
    emit(CartCubitDeleteLoadingState());
    final response = await cartRepository.deleteFromCart(productId);
    response.fold(
      (failure) => emit(CartCubitDeleteErrorState(failure.message)),
      (cart) {
        currentCart = cart;
        emit(CartCubitDeleteSuccessState(cart));
      },
    );
  }
}
