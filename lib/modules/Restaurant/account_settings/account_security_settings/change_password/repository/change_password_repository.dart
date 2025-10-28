import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import '../model/change_password_request.dart';

class ProviderChangePasswordRepository {
  final ApiService _apiService = ApiService();

  Future<void> changePassword(ProviderChangePasswordRequest request) async {
    try {
      await _apiService.put(
        ApiEndpoints.providerChangePassword,
        request.toJson(),
      );
      print("Calling endpoint: ${ApiEndpoints.providerChangePassword}");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
