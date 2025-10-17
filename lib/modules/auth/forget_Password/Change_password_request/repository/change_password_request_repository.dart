import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/model/change_password_request.dart';

class ChangePasswordRepository {
  final ApiService _apiService = ApiService();

  ChangePasswordRepository();


  Future<Map<String, dynamic>> changepassword(ChangePasswordRequest model) async {
    try {
      final response = await _apiService.post(ApiEndpoints.changePasswordRequest, model.toJson());
      return response;
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}


