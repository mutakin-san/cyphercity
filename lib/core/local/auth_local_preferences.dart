part of 'local.dart';

class AuthLocalPreferences {
  static const _isLoggedIn = "is_loggedin";

  static const _loginDetails = "login_details";

  Future<bool> get isLogin async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getBool(_isLoggedIn) ?? false);
  }

  Future<User?> get loginDetails async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stringData = prefs.getString(_loginDetails);
      if (stringData != null) {
        final data = User.fromJson(jsonDecode(prefs.getString(_loginDetails)!));
        return Future.value(data);
      } else {
        return Future.value(null);
      }
    } catch (e) {
        return Future.value(null);
    }
  }

  Future<bool> setLogin(bool value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return Future.value(prefs.setBool(_isLoggedIn, value));
    } catch (e) {
      return false;
    }
  }

  Future<bool> setLoginDetails(Map<String, dynamic>? json) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return Future.value(prefs.setString(_loginDetails, jsonEncode(json)));
    } catch (e) {
      return false;
    }
  }
}
