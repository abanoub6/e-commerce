import 'package:e_commerce_app/core/models/category.dart';
import 'package:e_commerce_app/core/models/brand.dart';

class ProductCartModel {
  final String id;
  final String title;
  final int quantity;
  final String imageCover;
  final Category category;
  final Brand? brand;
  final double ratingsAverage;

  const ProductCartModel({
    required this.id,
    required this.title,
    required this.quantity,
    required this.imageCover,
    required this.category,
    this.brand,
    required this.ratingsAverage,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    return ProductCartModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      quantity: json['quantity'] as int,
      imageCover: json['imageCover'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      brand:
          json['brand'] == null
              ? null
              : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      ratingsAverage: (json['ratingsAverage'] as num).toDouble(),
    );
  }
}
