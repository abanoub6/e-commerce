import 'package:e_commerce_app/features/cart/domain/entities/cart_entity.dart';

abstract class CartCubitStates {}

class CartCubitInitialState extends CartCubitStates {}

class CartCubitAddLoadingState extends CartCubitStates {}

class CartCubitAddErrorState extends CartCubitStates {
  final String message;
  CartCubitAddErrorState(this.message);
}

class CartCubitAddSuccessState extends CartCubitStates {}

class CartCubitUpdateLoadingState extends CartCubitStates {}

class CartCubitUpdateErrorState extends CartCubitStates {
  final String message;
  CartCubitUpdateErrorState(this.message);
}

class CartCubitUpdateSuccessState extends CartCubitStates {
  final CartEntity cart;
  CartCubitUpdateSuccessState(this.cart);
}

class CartCubitDeleteLoadingState extends CartCubitStates {}

class CartCubitDeleteErrorState extends CartCubitStates {
  final String message;
  CartCubitDeleteErrorState(this.message);
}

class CartCubitDeleteSuccessState extends CartCubitStates {
  final CartEntity cart;
  CartCubitDeleteSuccessState(this.cart);
}

class CartCubitGetLoadingState extends CartCubitStates {}

class CartCubitGetErrorState extends CartCubitStates {
  final String message;
  CartCubitGetErrorState(this.message);
}

class CartCubitGetSuccessState extends CartCubitStates {
  final CartEntity cart;
  CartCubitGetSuccessState(this.cart);
}
