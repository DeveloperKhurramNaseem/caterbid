import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/auth/login/model/Email_not_Verified_model.dart';
import 'package:caterbid/modules/auth/login/model/login_request_model.dart';
import 'package:caterbid/modules/auth/login/model/login_response_model.dart';

class LoginRepository {
  final ApiService _apiService = ApiService();

  Future<dynamic> login(LoginRequestModel model) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.login,
        {'email': model.email, 'password': model.password},
      );

      return LoginResponseModel.fromJson(response);
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);

      // Special handling for email not verified
      if (apiError.statusCode == 403 &&
          apiError.details != null &&
          apiError.details!['isOTPverified'] == false) {
        return EmailNotVerifiedModel.fromJson(apiError.details!, model.email);
      }

      throw apiError;
    }
  }
}
