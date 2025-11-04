import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/auth/verify_email_screen/model/verify_otp_response_model.dart';
import '../model/verify_otp_request.dart';


class EmailVerifyOtpRepository {
  final ApiService _api = ApiService();

  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel model) async {
    try {
      final response = await _api.post(ApiEndpoints.verifyOtp, model.toJson());
      return VerifyOtpResponseModel.fromJson(response);
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

    Future<void> resendOtp({required String email, required String role}) async {
    try {
      await _api.post(
        ApiEndpoints.resentEmailOtp,
        {"email": email, "role": role},
      );
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
