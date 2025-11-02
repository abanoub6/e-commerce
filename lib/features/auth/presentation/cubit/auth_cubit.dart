import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/domain/use-cases/login_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use-cases/register_use_case.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthCubit extends Cubit<AuthCubitStates> {
  final LoginUseCase _login;
  final RegisterUseCase _register;

  AuthCubit(this._login, this._register) : super(InitialState());

  Future<void> register(RegisterRequest request) async {
    emit(RegisterLoadingSate());

    final result = await _register(request);
    result.fold(
      (failure) => emit(RegisterFailiarState(message: failure.message)),
      (userEntity) => emit(RegisterSucessState()),
    );
  }

  Future<void> login(LoginRequest request) async {
    emit(LoginLoadingSate());
    final result = await _login(request);
    result.fold(
      (failure) => emit(LoginFailiarState(message: failure.message)),
      (userEntity) => emit(LoginSucessState()),
    );
  }
}
