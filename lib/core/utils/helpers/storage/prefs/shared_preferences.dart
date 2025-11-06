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

  static Future<void> setTokenIssueDate(String date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token_issue_date', date);
  }

  static Future<String?> getTokenIssueDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token_issue_date');
  }

  static Future<void> clearUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_role');
  }

  static Future<void> clearLocationRequired() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('location_required');
  }

  static Future<void> deleteTokenIssueDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token_issue_date');
  }
}
