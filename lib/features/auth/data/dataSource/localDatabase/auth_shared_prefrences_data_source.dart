import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefrencesDataSource extends AuthLocalDataSource {
  @override
  Future<void> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(KeysConstants.token, token);
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(KeysConstants.token)!;
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(KeysConstants.token);
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }
}
