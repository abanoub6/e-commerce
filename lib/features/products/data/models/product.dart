import 'package:e_commerce_app/core/models/category.dart';

import '../../../../core/models/brand.dart';

class Product {
  final int sold;
  final List<String> images;
  final int ratingsQuantity;
  final String id;
  final String title;
  final String slug;
  final String description;
  final int quantity;
  final int price;
  final String imageCover;
  final Category category;
  final Brand brand;
  final double ratingsAverage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? priceAfterDiscount;

  const Product({
    required this.sold,
    required this.images,
    required this.ratingsQuantity,
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCover,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
    required this.createdAt,
    required this.updatedAt,

    this.priceAfterDiscount,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    sold: json['sold'] as int,
    images: (json['images'] as List<dynamic>).cast(),

    ratingsQuantity: json['ratingsQuantity'] as int,
    id: json['_id'] as String,
    title: json['title'] as String,
    slug: json['slug'] as String,
    description: json['description'] as String,
    quantity: json['quantity'] as int,
    price: json['price'] as int,
    imageCover: json['imageCover'] as String,
    category: Category.fromJson(json['category'] as Map<String, dynamic>),
    brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
    ratingsAverage: (json['ratingsAverage'] as num).toDouble(),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),

    priceAfterDiscount: json['priceAfterDiscount'] as int?,
  );
}
