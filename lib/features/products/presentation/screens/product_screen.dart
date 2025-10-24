import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/dependency-injection/service_locator.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_states.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Products",
          style: TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.primaryColor, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) => productCubit..getProducts(categoryId),
        child: BlocListener<ProductCubit, ProductStates>(
          listener: (context, state) {
            if (state is ProductErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Route",
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "What do you search for?",
                            hintStyle: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 18,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 12,
                              ),
                              child: Icon(
                                Icons.search,
                                color: AppTheme.primaryColor,
                                size: 28,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                              borderSide: BorderSide(
                                color: AppTheme.secondaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: AppTheme.primaryColor,
                      size: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                BlocBuilder<ProductCubit, ProductStates>(
                  builder: (context, state) {
                    if (state is ProductLoadingState) {
                      return const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is ProductSuccsessState) {
                      return Expanded(
                        child: GridView.builder(
                          itemCount: state.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 270,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 5,
                                crossAxisCount: 2,
                              ),
                          itemBuilder: (context, index) {
                            return ProductItem(
                              index: index,
                              product: state.products[index],
                            );
                          },
                        ),
                      );
                    } else {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            "No products available",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
