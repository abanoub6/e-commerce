import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_shared_prefrences_data_source.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_api_data_source.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_remote_data_source.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setup() {
  serviceLocator.registerSingleton<AuthRemoteDataSource>(AuthApiDataSource());
  serviceLocator.registerSingleton<AuthLocalDataSource>(
    AuthSharedPrefrencesDataSource(),
  );
}
