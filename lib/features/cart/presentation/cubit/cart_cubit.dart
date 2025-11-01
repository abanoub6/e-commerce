import 'package:e_commerce_app/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<CartCubitStates> {
  CartEntity? currentCart;
  final CartRepository cartRepository;

  CartCubit(this.cartRepository) : super(CartCubitInitalState());
  Future<void> addToCart(String productId) async {
    emit(CartCubitAddLoadingState());
    final response = await cartRepository.addToCart(productId);
    response.fold(
      (failure) {
        emit(CartCubitAddErrorState(failure.message));
      },
      (_) {
        emit(CartCubitAddSuccessState());
      },
    );
  }

  Future<void> getCart() async {
    if (currentCart != null) {
      emit(CartCubitGetSuccessState(currentCart!));
      return;
    }

    emit(CartCubitGetLoadingState());
    final response = await cartRepository.getCart();
    response.fold((failure) => emit(CartCubitGetErrorState(failure.message)), (
      cart,
    ) {
      currentCart = cart;
      emit(CartCubitGetSuccessState(cart));
    });
  }

  Future<void> updateCartProductQuantity(String productId, int quanity) async {
    emit(CartCubitUpdateLoadingState());
    final response = await cartRepository.updateCart(productId, quanity);
    response.fold(
      (failure) {
        emit(CartCubitUpdateErrorState(failure.message));
      },
      (cart) {
        emit(CartCubitGetSuccessState(cart));
      },
    );
  }

  Future<void> deleteFromCart(String productId) async {
    emit(CartCubitDeleteLoadingState());
    final response = await cartRepository.deleteFromCart(productId);
    response.fold(
      (failure) {
        emit(CartCubitDeleteErrorState(failure.message));
      },
      (cart) {
        emit(CartCubitGetSuccessState(cart));
      },
    );
  }
}
