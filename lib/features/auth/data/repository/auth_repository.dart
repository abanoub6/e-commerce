import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_response.dart';

class AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepository({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });
  Future<RegisterResponse> register(RegisterRequest request) async {
    final responseBody = await authRemoteDataSource.register(request);
    await authLocalDataSource.saveToken(responseBody.token);
    return responseBody;
  }

  Future<LoginResponse> login(LoginRequest request) async {
    final responseBody = await authRemoteDataSource.login(request);
    await authLocalDataSource.saveToken(responseBody.token);
    return responseBody;
  }
}
