import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: AuthLocalDataSource)
class AuthSharedPrefrencesDataSource extends AuthLocalDataSource {
  final SharedPreferences prefs;
  AuthSharedPrefrencesDataSource(this.prefs);
  @override
  Future<void> saveToken(String token) async {
    try {
      await prefs.setString(KeysConstants.token, token);
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }

  @override
  Future<String> getToken() async {
    try {
      return prefs.getString(KeysConstants.token)!;
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      prefs.remove(KeysConstants.token);
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }
}
