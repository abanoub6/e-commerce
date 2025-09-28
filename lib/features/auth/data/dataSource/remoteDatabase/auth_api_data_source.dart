import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_response.dart';

class AuthApiDataSource extends AuthRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await dio.post(
      ApiConstants.registerEndPoint,
      data: request.toJson(),
    );
    final responseBody = RegisterResponse.fromJson(response.data);

    return responseBody;
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await dio.post(
      ApiConstants.loginEndPoint,
      data: request.toJson(),
    );
    final responseBody = LoginResponse.fromJson(response.data);
    return responseBody;
  }
}
