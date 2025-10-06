import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_response.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRemoteDataSource)
class AuthApiDataSource extends AuthRemoteDataSource {
  final Dio _dio;
  AuthApiDataSource(this._dio);
  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        ApiConstants.registerEndPoint,
        data: request.toJson(),
      );
      final responseBody = RegisterResponse.fromJson(response.data);
      return responseBody;
    } on DioException catch (exeption) {
      throw RemoteExeption(
        exeption.response?.data["message"] ?? "Some thing went wrong",
      );
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginEndPoint,
        data: request.toJson(),
      );
      final responseBody = LoginResponse.fromJson(response.data);
      return responseBody;
    } on DioException catch (exeption) {
      throw RemoteExeption(
        exeption.response?.data["message"] ?? "Some thing went wrong",
      );
    }
  }
}
