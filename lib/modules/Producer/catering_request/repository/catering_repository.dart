// repository/catering_repository.dart
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import '../model/catering_request_model.dart';
import '../model/catering_response_model.dart';

class CateringRepository {
  final ApiService _apiService = ApiService();

  Future<CateringResponseModel> createRequest(
    CateringRequestModel model,
  ) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.createCateringRequest,
        model.toJson(),
      );
      final token = await SecureStorage.getToken();
      print('🔑 Token from storage: $token');

      return CateringResponseModel.fromJson(response);
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
