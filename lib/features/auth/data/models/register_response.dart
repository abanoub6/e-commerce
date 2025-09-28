import 'user.dart';

class RegisterResponse {
  final String? message;
  final User user;
  final String token;

  const RegisterResponse({
    this.message,
    required this.user,
    required this.token,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'user': user.toJson(),
    'token': token,
  };
}
