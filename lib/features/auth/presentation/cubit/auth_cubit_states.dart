abstract class AuthCubitStates {}

class InitialState extends AuthCubitStates {}

class LoginLoadingSate extends AuthCubitStates {}

class LoginSucessState extends AuthCubitStates {}

class LoginFailiarState extends AuthCubitStates {
  final String message;

  LoginFailiarState({required this.message});
}

class RegisterLoadingSate extends AuthCubitStates {}

class RegisterSucessState extends AuthCubitStates {}

class RegisterFailiarState extends AuthCubitStates {
  final String message;

  RegisterFailiarState({required this.message});
}
