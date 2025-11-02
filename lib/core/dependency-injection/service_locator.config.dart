// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:e_commerce_app/core/dependency-injection/register_module.dart'
    as _i585;
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart'
    as _i502;
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_shared_prefrences_data_source.dart'
    as _i1029;
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_api_data_source.dart'
    as _i573;
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_remote_data_source.dart'
    as _i531;
import 'package:e_commerce_app/features/auth/data/repository/auth_repository_imp.dart'
    as _i163;
import 'package:e_commerce_app/features/auth/domain/repository/auth_repository.dart'
    as _i867;
import 'package:e_commerce_app/features/auth/domain/use-cases/login_use_case.dart'
    as _i799;
import 'package:e_commerce_app/features/auth/domain/use-cases/register_use_case.dart'
    as _i672;
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i130;
import 'package:e_commerce_app/features/cart/data/data-sources/cart_api_remote_data_source.dart'
    as _i472;
import 'package:e_commerce_app/features/cart/data/data-sources/cart_remote_data_source.dart'
    as _i30;
import 'package:e_commerce_app/features/cart/data/repository/cart_repository_imp.dart'
    as _i440;
import 'package:e_commerce_app/features/cart/domain/repository/cart_repository.dart'
    as _i613;
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart'
    as _i6;
import 'package:e_commerce_app/features/home/data/data-sources/remote-data-source/home_remote_data_source.dart'
    as _i412;
import 'package:e_commerce_app/features/home/data/data-sources/remote-data-source/home_remote_data_source_api.dart'
    as _i420;
import 'package:e_commerce_app/features/home/data/repository/home_repository_imp.dart'
    as _i372;
import 'package:e_commerce_app/features/home/domain/repository/home_repository.dart'
    as _i535;
import 'package:e_commerce_app/features/home/domain/use-cases/categories_use_case.dart'
    as _i600;
import 'package:e_commerce_app/features/home/presentation/cubit/home_cubit.dart'
    as _i647;
import 'package:e_commerce_app/features/products/data/dataSource/remote/remote_api_products_data_source.dart'
    as _i484;
import 'package:e_commerce_app/features/products/data/dataSource/remote/remote_products_data_source.dart'
    as _i353;
import 'package:e_commerce_app/features/products/data/repository/product_repeository_imp.dart'
    as _i785;
import 'package:e_commerce_app/features/products/domain/repository/product_repository.dart'
    as _i474;
import 'package:e_commerce_app/features/products/domain/use-cases/get_products_use_case.dart'
    as _i144;
import 'package:e_commerce_app/features/products/presentation/cubit/product_cubit.dart'
    as _i814;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i361.Dio>(
      () => registerModule.dio,
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i412.HomeRemoteDataSource>(
      () => _i420.HomeRemoteDataSourceApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i353.RemoteProductsDataSource>(
      () => _i484.RemoteApiProductsDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i30.CartRemoteDataSource>(
      () => _i472.CartApiRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i502.AuthLocalDataSource>(
      () =>
          _i1029.AuthSharedPrefrencesDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i531.AuthRemoteDataSource>(
      () => _i573.AuthApiDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i535.HomeRepository>(
      () => _i372.HomeRepositoryImp(gh<_i412.HomeRemoteDataSource>()),
    );
    gh.singleton<_i600.CategoriesUseCase>(
      () => _i600.CategoriesUseCase(gh<_i535.HomeRepository>()),
    );
    gh.singleton<_i867.AuthRepository>(
      () => _i163.AuthRepositoryImp(
        authRemoteDataSource: gh<_i531.AuthRemoteDataSource>(),
        authLocalDataSource: gh<_i502.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i474.ProductRepository>(
      () => _i785.ProductRepeositoryImp(gh<_i353.RemoteProductsDataSource>()),
    );
    gh.singleton<_i799.LoginUseCase>(
      () => _i799.LoginUseCase(gh<_i867.AuthRepository>()),
    );
    gh.singleton<_i672.RegisterUseCase>(
      () => _i672.RegisterUseCase(gh<_i867.AuthRepository>()),
    );
    gh.lazySingleton<_i613.CartRepository>(
      () => _i440.CartRepositoryImp(gh<_i30.CartRemoteDataSource>()),
    );
    gh.lazySingleton<_i647.HomeCubit>(
      () => _i647.HomeCubit(gh<_i600.CategoriesUseCase>()),
    );
    gh.singleton<_i130.AuthCubit>(
      () => _i130.AuthCubit(
        gh<_i799.LoginUseCase>(),
        gh<_i672.RegisterUseCase>(),
      ),
    );
    gh.lazySingleton<_i144.GetProductsUseCase>(
      () => _i144.GetProductsUseCase(gh<_i474.ProductRepository>()),
    );
    gh.factory<_i6.CartCubit>(() => _i6.CartCubit(gh<_i613.CartRepository>()));
    gh.factory<_i814.ProductCubit>(
      () => _i814.ProductCubit(gh<_i144.GetProductsUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i585.RegisterModule {}
