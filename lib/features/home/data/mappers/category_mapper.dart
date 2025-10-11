import 'package:e_commerce_app/features/home/data/models/category.dart';
import 'package:e_commerce_app/features/home/domain/entities/category_entity.dart';

extension CategoryMapper on Category {
  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name, imageUrl: image);
  }
}
