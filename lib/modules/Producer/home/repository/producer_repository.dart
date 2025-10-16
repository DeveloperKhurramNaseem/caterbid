import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import '../model/producer_request_model.dart';

class ProducerRepository {
  final ApiService _apiService = ApiService();

  Future<List<ProducerRequest>> fetchRequests() async {
    try {
      final response = await _apiService.get(ApiEndpoints.getMyRequests);

      // Ensure the response is a list
      if (response is List) {
        // Parse list into ProducerRequest models
        return response
            .map((item) => ProducerRequest.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(message: 'Invalid response format: Expected a list');
      }
    } catch (error) {
      // Centralized error handling
      throw ApiErrorHandler.handle(error);
    }
  }
}


