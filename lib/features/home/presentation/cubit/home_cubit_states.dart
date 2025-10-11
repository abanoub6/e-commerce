import 'package:e_commerce_app/features/home/domain/entities/category_entity.dart';

abstract class HomeCubitStates {}

class IntialHomeState extends HomeCubitStates {}

class LoadingHomeState extends HomeCubitStates {}

class SuccessHomeState extends HomeCubitStates {
  final List<CategoryEntity> categories;

  SuccessHomeState(this.categories);
}

class ErrorHomeState extends HomeCubitStates {
  final String errorMessage;

  ErrorHomeState(this.errorMessage);
}
