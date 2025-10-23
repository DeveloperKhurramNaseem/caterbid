import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';

class ProviderRequestsRepository {
  final ApiService _apiService = ApiService();

  /// Fetch all open requests for the provider
  Future<List<ProviderRequest>> fetchProviderRequests() async {
    try {
      final response = await _apiService.get(ApiEndpoints.providerRequests);

      if (response is List) {
        return response
            .map((e) => ProviderRequest.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(message: "Unexpected API response format");
      }
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
