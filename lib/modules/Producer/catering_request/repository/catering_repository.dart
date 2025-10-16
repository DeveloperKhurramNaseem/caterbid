import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/network/api_service.dart';
import '../model/catering_request_model.dart';

class CateringRepository {
  final ApiService _apiService = ApiService();

  Future<void> createRequest(CateringRequestModel model) async {
    try {
      await _apiService.post(
        ApiEndpoints.createCateringRequest,
        model.toJson(),
      );
      // No need to parse or return response
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
