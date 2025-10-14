import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_exception.dart';
import '../model/verify_otp_request.dart';

class VerifyOtpRepository {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> verifyOtp(VerifyOtpRequestModel model) async {
    try {
      final response = await _api.post(ApiEndpoints.verifyOtp, model.toJson());
      return response;
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
