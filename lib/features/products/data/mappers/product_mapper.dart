import 'package:e_commerce_app/features/products/data/models/product.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';

extension ProductMapper on Product {
  ProductEntity toEntity() {
    return ProductEntity(
      imageCover: imageCover,
      sold: sold,
      images: images,
      ratingsQuantity: ratingsQuantity,
      id: id,
      title: title,
      description: description,
      quantity: quantity,
      price: price,
    );
  }
}
