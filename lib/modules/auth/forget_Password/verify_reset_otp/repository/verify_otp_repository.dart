import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/model/verify_otp_request.dart';

class VerifyOtpRepository {
  final ApiService _apiService = ApiService();

  Future<void> verifyOtp(VerifyOtpRequest model) async {
    try {
      final response = await _apiService.post(ApiEndpoints.verifyResetOtp, model.toJson());
      return response;
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
