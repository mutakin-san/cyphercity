import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class LoginPrefService {
  static const _isLoggedIn = "is_loggedin";

  static const _loginDetails = "login_details";

  static Future<bool> get isLogin async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getBool(_isLoggedIn) ?? false);
  }

  static Future<User?> get loginDetails async {
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

  static Future<bool> setLogin(bool value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return Future.value(prefs.setBool(_isLoggedIn, value));
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setLoginDetails(Map<String, dynamic>? json) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return Future.value(prefs.setString(_loginDetails, jsonEncode(json)));
    } catch (e) {
      return false;
    }
  }
}
