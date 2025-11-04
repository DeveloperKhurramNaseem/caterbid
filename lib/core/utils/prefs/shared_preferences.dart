import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }

  static Future<void> saveLocationRequired(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('location_required', value);
  }

  static Future<bool?> getLocationRequired() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('location_required');
  }
}
