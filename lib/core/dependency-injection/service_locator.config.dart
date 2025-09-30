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
import 'package:e_commerce_app/features/auth/data/repository/auth_repository.dart'
    as _i547;
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i130;
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
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i502.AuthLocalDataSource>(
      () =>
          _i1029.AuthSharedPrefrencesDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i531.AuthRemoteDataSource>(
      () => _i573.AuthApiDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i547.AuthRepository>(
      () => _i547.AuthRepository(
        authRemoteDataSource: gh<_i531.AuthRemoteDataSource>(),
        authLocalDataSource: gh<_i502.AuthLocalDataSource>(),
      ),
    );
    gh.singleton<_i130.AuthCubit>(
      () => _i130.AuthCubit(gh<_i547.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i585.RegisterModule {}
