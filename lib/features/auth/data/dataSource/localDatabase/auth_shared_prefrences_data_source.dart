import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/auth/data/dataSource/localDatabase/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefrencesDataSource extends AuthLocalDataSource {
  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KeysConstants.token, token);
  }

  @override
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeysConstants.token)!;
    // we but (!) because we are sure that token is saved in shared prefrences
    // and it will not be null
    // if we try to get token without saving it first it will throw an error
    // and i will handle it in repository layer
    // by checking if token is null or not
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(KeysConstants.token);
  }
}
