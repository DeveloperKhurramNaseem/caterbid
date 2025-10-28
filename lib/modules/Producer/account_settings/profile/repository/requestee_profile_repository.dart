import 'dart:convert';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/model/requestee_profile_model.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/model/update_requestee_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequesteeRepository {
  final ApiService _api = ApiService();
  static const _cacheKey = 'cached_requestee_profile';

  // ✅ Fetch profile (cache first, silent background refresh)
  Future<RequesteeModel> fetchProfile({bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cached = prefs.getString(_cacheKey);
      if (cached != null) {
        final cachedUser = RequesteeModel.fromJson(jsonDecode(cached));
        _refreshProfileSilently();
        return cachedUser;
      }
    }
    return await refreshProfile();
  }

  // ✅ Always fetch latest from server
  Future<RequesteeModel> refreshProfile() async {
    final response = await _api.get(ApiEndpoints.getRequesteeProfile);
    final data = response['requestee'] ?? response['user'] ?? response;
    final user = RequesteeModel.fromJson(data);
    await cacheProfile(user);
    return user;
  }

  // ✅ Update profile smoothly
  Future<RequesteeModel> updateProfile(UpdateRequesteeModel model) async {
    final response = await _api.putMultipart(
      ApiEndpoints.updateRequesteeProfileDetails,
      fields: model.toFields(),
      file: model.file,
      fileFieldName: 'profilePicture',
    );

    final updatedData = response['user'];
    final updatedUser = RequesteeModel.fromJson(updatedData);

    // Cache and return updated model directly (no flicker)
    await cacheProfile(updatedUser);
    return updatedUser;
  }

  // ✅ Save to local cache
  Future<void> cacheProfile(RequesteeModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, jsonEncode(user.toJson()));
  }

  // ✅ Clear cache + ensure full removal for new login
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    await prefs.clear(); // ensures old user data gone
  }

  // ✅ Silent background refresh (no throw)
  Future<void> _refreshProfileSilently() async {
    try {
      await refreshProfile();
    } catch (_) {}
  }
}
