// import 'dart:convert';
// import 'package:caterbid/core/network/api_endpoints.dart';
// import 'package:caterbid/core/network/api_service.dart';
// import 'package:caterbid/data/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserRepository {
//   final ApiService _api = ApiService();
//   static const _cacheKey = 'cached_requestee_profile';

//   Future<RequesteeModel> fetchUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cached = prefs.getString(_cacheKey);

//     if (cached != null) {
//       final cachedUser = RequesteeModel.fromJson(jsonDecode(cached));
//       _refreshUserSilently();
//       return cachedUser;
//     }
//     return await refreshUser();
//   }

//   Future<RequesteeModel> refreshUser() async {
//     final response = await _api.get(ApiEndpoints.getRequesteeProfile);
//     final data = response['user'] ?? response;
//     final user = RequesteeModel.fromJson(data);

//     await cacheUser(user);
//     return user;
//   }

//   Future<void> _refreshUserSilently() async {
//     try {
//       await refreshUser();
//     } catch (_) {}
//   }

//   Future<void> cacheUser(RequesteeModel user) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_cacheKey, jsonEncode(user.toJson()));
//   }

//   Future<void> clearCache() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_cacheKey);
//   }
// }