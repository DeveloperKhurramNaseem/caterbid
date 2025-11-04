import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';

class ProvidorDeleteAccount {
  final ApiService _apiService = ApiService();

  Future<void> deleteAccount() async {
    final response = await _apiService.delete(
      ApiEndpoints.providerDeleteAccount,
      {}, // No body required for delete account
    );

    if (response == null || response['message'] == null) {
      throw Exception("Unexpected API response");
    }

    return;
  }
}
