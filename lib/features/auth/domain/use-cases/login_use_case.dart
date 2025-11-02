import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoginUseCase {
  AuthRepository repo;
  LoginUseCase(this.repo);
  Future<Either<Failure, UserEntity>> call(LoginRequest request) async {
    return await repo.login(request);
  }
}
