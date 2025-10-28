import 'dart:convert';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/Restaurant/account_settings/model/provider_profile_model.dart';
import 'package:caterbid/modules/Restaurant/account_settings/model/update_provider_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderRepository {
  final ApiService _api = ApiService();
  static const _cacheKey = 'cached_provider_profile';

  // Fetch with local cache + silent refresh
  Future<ProviderModel> fetchProfile({bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cached = prefs.getString(_cacheKey);
      if (cached != null) {
        final cachedUser = ProviderModel.fromJson(jsonDecode(cached));
        _refreshProfileSilently();
        return cachedUser;
      }
    }

    return await refreshProfile();
  }

  Future<ProviderModel> refreshProfile() async {
    final response = await _api.get(ApiEndpoints.getProviderProfileDetails);
    final data = response['provider'] ?? response;
    final user = ProviderModel.fromJson(data);
    await cacheProfile(user);
    return user;
  }

  Future<ProviderModel> updateProfile(UpdateProviderModel model) async {
    final response = await _api.putMultipart(
      ApiEndpoints.bussinessProfileSetup,
      fields: model.toFields(),
      file: model.file,
      fileFieldName: 'profilePicture',
    );

    final updatedData = response['provider'];
    final updatedUser = ProviderModel.fromJson(updatedData);
    await cacheProfile(updatedUser);
    return updatedUser;
  }

  Future<void> cacheProfile(ProviderModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, jsonEncode(user.toJson()));
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }

  Future<void> _refreshProfileSilently() async {
    try {
      await refreshProfile();
    } catch (_) {}
  }
}
