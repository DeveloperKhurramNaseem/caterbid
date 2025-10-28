// import 'dart:convert';
// import 'package:caterbid/data/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserPrefs {
//   static const _userKey = 'user_profile';

//   static Future<void> saveUser(UserModel user) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_userKey, jsonEncode(user.toJson()));
//   }

//   static Future<UserModel?> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonStr = prefs.getString(_userKey);
//     if (jsonStr == null) return null;
//     return UserModel.fromJson(jsonDecode(jsonStr));
//   }

//   static Future<void> clear() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_userKey);
//   }
// }