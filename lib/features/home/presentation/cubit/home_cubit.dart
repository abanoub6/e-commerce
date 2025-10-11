import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/home/domain/entities/category_entity.dart';
import 'package:e_commerce_app/features/home/domain/use-cases/categories_use_case.dart';
import 'package:e_commerce_app/features/home/presentation/cubit/home_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class HomeCubit extends Cubit<HomeCubitStates> {
  CategoriesUseCase categoriesUseCase;
  HomeCubit(this.categoriesUseCase) : super(IntialHomeState()) {
    getCategories();
  }
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    emit(LoadingHomeState());
    final result = await categoriesUseCase.getCategories();
    result.fold(
      (failure) {
        emit(ErrorHomeState(failure.message));
      },
      (categories) {
        emit(SuccessHomeState(categories));
      },
    );
    return result;
  }
}
