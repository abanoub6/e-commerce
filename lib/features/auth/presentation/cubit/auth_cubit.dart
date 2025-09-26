import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_shared_prefrences_data_source.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/remoteDatabase/auth_api_data_source.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit_states.dart';
import 'package:e_commerce_app/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthCubitStates> {
  late final AuthRepository repo;
  AuthCubit() : super(InitialState()) {
    repo = AuthRepository(
      authRemoteDataSource: AuthApiDataSource(),
      authLocalDataSource: AuthSharedPrefrencesDataSource(),
    );
  }

  Future<void> register(RegisterRequest request) async {
    emit(RegisterLoadingSate());
    try {
      await repo.register(request);
      emit(RegisterSucessState());
    } catch (error) {
      emit(RegisterFailiarState(message: error.toString()));
    }
  }

  Future<void> login(LoginRequest request) async {
    emit(LoginLoadingSate());
    try {
      await repo.login(request);
      emit(LoginSucessState());
    } catch (error) {
      emit(LoginFailiarState(message: error.toString()));
    }
  }
}
