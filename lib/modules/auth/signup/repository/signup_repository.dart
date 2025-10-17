import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/modules/auth/signup/model/signup_request.dart';
import 'package:caterbid/core/network/api_exception.dart';

class SignUpRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> signUp(SignUpRequestModel model) async {
    try {
      final response = await _apiService.post(ApiEndpoints.signUp, model.toJson());
      return response;
    } catch (error) {
      // Converting any thrown error to a clean ApiException
      throw ApiErrorHandler.handle(error);
    }
  }
}
