import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_2024/data/models/responses/auth_response_model.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', data.toJson());
    return;
  }

  Future<AuthResponseModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('auth_data');
    return AuthResponseModel.fromJson(data!);
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
    return;
  }

  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_data');
  }
}