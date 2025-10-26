import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve // to make sure that the instance is created before it's requested because it's async
  Future<Dio> get dio async {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(KeysConstants.token);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null && token.isNotEmpty) {
            options.headers[ApiConstants.tokenKey] = token;
          }
          return handler.next(options);
        },
      ),
    );

    return dio;
  }

  @preResolve // to make sure that the instance is created before it's requested because it's async
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  // Also, make sure you await for your configure function before running the App.
}
