import 'package:e_commerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/features/cart/domain/entities/product_cart_entity.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit_states.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = 'cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: BlocBuilder<CartCubit, CartCubitStates>(
        builder: (context, state) {
          if (state is CartCubitGetLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartCubitGetErrorState) {
            return Center(child: Text(state.message));
          } else if (state is CartCubitGetSuccessState) {
            if (state.cart.cartItems.isEmpty) {
              return const Center(child: Text('Your cart is empty'));
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.cart.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemCard(
                          cartItem: CartItemEntity(
                            count: state.cart.cartItems[index].count,

                            price: state.cart.cartItems[index].price,
                            product: ProductCartEntity(
                              id: state.cart.cartItems[index].product.id,
                              title: state.cart.cartItems[index].product.title,
                              quantity: 5,
                              imageCover:
                                  state
                                      .cart
                                      .cartItems[index]
                                      .product
                                      .imageCover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total price: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${state.cart.totalCartPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
