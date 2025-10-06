import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: AuthLocalDataSource)
class AuthSharedPrefrencesDataSource extends AuthLocalDataSource {
  final SharedPreferences _prefs;
  AuthSharedPrefrencesDataSource(this._prefs);
  @override
  Future<void> saveToken(String token) async {
    try {
      await _prefs.setString(KeysConstants.token, token);
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }

  @override
  Future<String> getToken() async {
    try {
      return _prefs.getString(KeysConstants.token)!;
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      _prefs.remove(KeysConstants.token);
    } catch (exeption) {
      throw LocalExeption(exeption.toString());
    }
  }
}
