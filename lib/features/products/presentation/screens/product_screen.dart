import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = 'product-screen';
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Padding(
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
                          padding: const EdgeInsetsDirectional.only(start: 12),
                          child: Icon(
                            Icons.search,
                            color: AppTheme.primaryColor,
                            size: 28,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35)),
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
            Expanded(
              child: GridView.builder(
                itemCount: 18,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 250,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return ProductItem(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
