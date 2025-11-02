import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/dependency-injection/service_locator.dart';
import 'package:e_commerce_app/core/utils/ui_utiles.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit_states.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_states.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = 'product-screen';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final ProductCubit productCubit;

  @override
  void initState() {
    super.initState();
    productCubit = serviceLocator.get<ProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)!.settings.arguments as String?;

    return BlocListener<CartCubit, CartCubitStates>(
      listener: (context, state) {
        if (state is CartCubitAddLoadingState) {
          UIUtiles.showLoading(context);
        } else if (state is CartCubitAddErrorState) {
          UIUtiles.hideLoading(context);
          UIUtiles.showMessage(state.message);
        } else if (state is CartCubitAddSuccessState) {
          UIUtiles.hideLoading(context);
          UIUtiles.showMessage("Product added to cart successfully.");
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // ✅ AppBar بنفس شكل اللي في cart screen
        appBar: AppBar(
          title: const Text(
            'Products',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          elevation: 3,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 26,
              ),
              onPressed:
                  () => Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          ],
        ),

        body: BlocProvider(
          create: (context) => productCubit..getProducts(categoryId),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                _buildSearchBar(context),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<ProductCubit, ProductStates>(
                    builder: (context, state) {
                      final isLoading = state is ProductLoadingState;

                      return Skeletonizer(
                        enabled: isLoading,
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(top: 4),
                          itemCount:
                              state is ProductSuccsessState
                                  ? state.products.length
                                  : 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 12,
                                mainAxisExtent: 270,
                              ),
                          itemBuilder: (context, index) {
                            if (state is ProductSuccsessState) {
                              return ProductItem(
                                index: index,
                                product: state.products[index],
                              );
                            } else {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search products...",
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.blueAccent,
            size: 26,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
