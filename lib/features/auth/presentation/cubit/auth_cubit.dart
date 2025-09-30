import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit_states.dart';
import 'package:e_commerce_app/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthCubit extends Cubit<AuthCubitStates> {
  late final AuthRepository repo;
  AuthCubit(this.repo) : super(InitialState());

  Future<void> register(RegisterRequest request) async {
    emit(RegisterLoadingSate());

    final result = await repo.register(request);
    result.fold(
      (failure) => emit(RegisterFailiarState(message: failure.message)),
      (resisterResponse) => emit(RegisterSucessState()),
    );
  }

  Future<void> login(LoginRequest request) async {
    emit(LoginLoadingSate());
    final result = await repo.login(request);
    result.fold(
      (failure) => emit(LoginFailiarState(message: failure.message)),
      (loginResponse) => emit(LoginSucessState()),
    );
  }
}
