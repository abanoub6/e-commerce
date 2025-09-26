import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_response/register_response.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponse> register(RegisterRequest request);
  Future<LoginResponse> login(LoginRequest request);
}
