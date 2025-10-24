import 'dart:developer';
import 'package:e_commerce_app/features/product-details/presentation/widgets/colors_selector_widget.dart';
import 'package:e_commerce_app/features/product-details/presentation/widgets/images_slider.dart';
import 'package:e_commerce_app/features/product-details/presentation/widgets/quantity_selector_widget.dart';
import 'package:e_commerce_app/features/product-details/presentation/widgets/sizes_selector_widget%20.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = 'product-details-screen';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantityBought = 1;

  void onQuantityChanged(int quantity) {
    setState(() {
      quantityBought = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== images slider =====
            ImagesSlider(images: product.images),

            const SizedBox(height: 8),

            // ===== Product Name & Price =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    'EG${product.price}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ===== Sold + Rating + Quantity =====
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    " ${product.sold} Sold",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(
                  '4.5 (${product.ratingsQuantity} Reviews)',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Spacer(),
                QuantitySelector(onQuantityChanged: onQuantityChanged),
              ],
            ),

            const SizedBox(height: 8),

            // ===== Description =====
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              maxLines: 4,
              product.description,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 8),

            // ===== Sizes =====
            const Text(
              "Sizes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const SizeSelector(),

            const SizedBox(height: 8),

            // ===== Colors =====
            const Text(
              "Colors",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const ColorSelector(),

            const SizedBox(height: 8),

            // ===== Total & Add Button =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'EG${(product.price * quantityBought).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      log('Add to Cart clicked!');
                      log('Selected Quantity: $quantityBought');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
