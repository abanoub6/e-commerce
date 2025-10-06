import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/data/mapers/user_model_mapper.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImp({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });
  //left and right are classes that inherit from either
  @override
  Future<Either<Failure, UserEntity>> register(RegisterRequest request) async {
    try {
      final responseBody = await authRemoteDataSource.register(request);
      await authLocalDataSource.saveToken(responseBody.token);
      return Right(responseBody.user.toEntity());
    } on AppExepetions catch (exeption) {
      return Left(Failure(exeption.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(LoginRequest request) async {
    try {
      final responseBody = await authRemoteDataSource.login(request);
      await authLocalDataSource.saveToken(responseBody.token);
      return Right(responseBody.user.toEntity());
    } on AppExepetions catch (exeption) {
      return Left(Failure(exeption.message));
    }
  }
}
