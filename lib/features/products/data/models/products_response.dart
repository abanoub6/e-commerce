import 'package:e_commerce_app/features/products/data/models/product.dart';

import '../../../../core/models/metadata.dart';

class ProductsResponse {
  final int results;
  final Metadata metadata;
  final List<Product> products;

  const ProductsResponse({
    required this.results,
    required this.metadata,
    required this.products,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      results: json['results'] as int,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      products:
          (json['data'] as List<dynamic>)
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
