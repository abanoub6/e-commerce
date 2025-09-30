import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_response.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepository({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });
  //left and right are classes that inherit from either
  Future<Either<Failure, RegisterResponse>> register(
    RegisterRequest request,
  ) async {
    try {
      final responseBody = await authRemoteDataSource.register(request);
      await authLocalDataSource.saveToken(responseBody.token);
      return Right(responseBody);
    } on AppExepetions catch (exeption) {
      return Left(Failure(exeption.message));
    }
  }

  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final responseBody = await authRemoteDataSource.login(request);
      await authLocalDataSource.saveToken(responseBody.token);
      return Right(responseBody);
    } on AppExepetions catch (exeption) {
      return Left(Failure(exeption.message));
    }
  }
}
