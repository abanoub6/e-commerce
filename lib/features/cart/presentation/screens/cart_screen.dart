import 'package:e_commerce_app/core/utils/ui_utiles.dart';
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
  late final CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cartCubit = context.read<CartCubit>();
    cartCubit.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          '🛒 My Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<CartCubit, CartCubitStates>(
        listener: (context, state) {
          final hasData =
              cartCubit.currentCart != null &&
              cartCubit.currentCart!.cartItems.isNotEmpty;

          if (state is CartCubitGetLoadingState ||
              state is CartCubitUpdateLoadingState ||
              state is CartCubitDeleteLoadingState) {
            if (hasData) UIUtiles.showLoading(context);
          }

          if (state is CartCubitGetSuccessState ||
              state is CartCubitUpdateSuccessState ||
              state is CartCubitDeleteSuccessState) {
            UIUtiles.hideLoading(context);
            if (state is CartCubitUpdateSuccessState) {
              UIUtiles.showMessage('تم تحديث الكمية بنجاح ✅');
            } else if (state is CartCubitDeleteSuccessState) {
              UIUtiles.showMessage('تم حذف المنتج من السلة 🗑️');
            }
          }

          if (state is CartCubitGetErrorState ||
              state is CartCubitUpdateErrorState ||
              state is CartCubitDeleteErrorState) {
            UIUtiles.hideLoading(context);
            UIUtiles.showMessage((state as dynamic).message);
          }
        },
        builder: (context, state) {
          final cart = cartCubit.currentCart;

          // 🌀 تحميل أول مرة
          if ((state is CartCubitGetLoadingState ||
                  state is CartCubitInitialState) &&
              (cart == null || cart.cartItems.isEmpty)) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff4e54c8)),
            );
          }

          // 🛍️ لو السلة فاضية
          if (cart == null || cart.cartItems.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Your cart is empty ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Start adding some products to your cart!",
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          // ✅ لو في بيانات
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical:
                        12, // 👈 ده اللي بيمنع أول عنصر يدخل تحت الـ AppBar
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cart.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CartItemCard(cartItem: item),
                      ),
                    );
                  },
                ),
              ),

              // 💵 الإجمالي و زر Checkout
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'EGP ${cart.totalCartPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff4e54c8),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          UIUtiles.showMessage("Checkout not implemented yet ");
                        },
                        icon: const Icon(
                          Icons.payment_rounded,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Checkout',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4e54c8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
