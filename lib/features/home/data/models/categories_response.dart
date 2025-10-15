import 'package:e_commerce_app/core/metadata.dart';

import '../../../../core/category.dart';

class CategoriesResponse {
  final int results;
  final Metadata metadata;
  final List<Category> categories;

  const CategoriesResponse({
    required this.results,
    required this.metadata,
    required this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      results: json['results'] as int,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      categories:
          (json['data'] as List)
              .map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
