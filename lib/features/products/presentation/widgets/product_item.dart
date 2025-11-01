import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit_states.dart';
import 'package:e_commerce_app/features/product-details/presentation/screens/product_details_screen.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final int index;
  final ProductEntity product;
  const ProductItem({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartCubitStates>(
      listener: (context, state) {
        if (state is CartCubitAddLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Adding to cart..."),
              duration: Duration(milliseconds: 1000),
            ),
          );
        } else if (state is CartCubitAddSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Added to cart successfully ✅"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is CartCubitAddErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${state.message}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(ProductDetailsScreen.routeName, arguments: product);
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Image.network(
                        product.imageCover,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.white,
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        product.title,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        maxLines: 1,
                        product.description,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppTheme.secondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            product.priceAfterDiscount != null
                                ? "\$${product.priceAfterDiscount}"
                                : "\$${product.price}",
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            product.priceAfterDiscount != null
                                ? "\$${product.price}"
                                : "",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppTheme.secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                size: 16,
                                color:
                                    index < product.ratingsQuantity
                                        ? Colors.amber
                                        : AppTheme.secondaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<CartCubit>(
                                  context,
                                ).addToCart(product.id);
                              },
                              child: const Icon(Icons.add, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
