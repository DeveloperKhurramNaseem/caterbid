import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/model/requestee_change_password_request.dart';

class RequesteeChangePasswordRepository {
  final ApiService _apiService = ApiService();

  Future<void> changePassword(RequesteeChangePasswordRequest request) async {
    try {
      await _apiService.put(ApiEndpoints.requesteeChangePassword, request.toJson());
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
