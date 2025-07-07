import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static const String _tokenKey = 'token';
  static const String _onboardingKey = 'hasSeenOnboarding';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<bool> getOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_onboardingKey) ?? false;
  }
}
