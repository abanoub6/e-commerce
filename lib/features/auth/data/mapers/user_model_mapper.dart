import 'package:e_commerce_app/features/auth/data/models/user.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';

extension UserModelMapper on User {
  UserEntity toEntity() {
    return UserEntity(name: name, email: email, role: role);
  }
}
