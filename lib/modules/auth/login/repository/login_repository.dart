import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/auth/login/model/login_request_model.dart';
import 'package:caterbid/modules/auth/login/model/login_response_model.dart';

class LoginRepository {
  final ApiService _apiService = ApiService();

  Future<LoginResponseModel> login(LoginRequestModel model) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.login,
        {'email': model.email, 'password': model.password},
      );
      return LoginResponseModel.fromJson(response);
    } catch (error) {
      // Converting any thrown error to a clean ApiException
      throw ApiErrorHandler.handle(error);
    }
  }
}
