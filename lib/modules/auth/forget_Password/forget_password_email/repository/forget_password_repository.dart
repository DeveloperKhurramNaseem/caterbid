import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/model/forget_password_request.dart';
import 'package:caterbid/core/network/api_exception.dart';

class ForgetpasswordRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> forgetPassword(ForgetPasswordRequest model) async {
    try {
      final response = await _apiService.post(ApiEndpoints.forgotPassword, model.toJson());
      return response;
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
