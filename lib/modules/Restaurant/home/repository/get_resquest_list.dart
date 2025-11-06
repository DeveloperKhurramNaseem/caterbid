import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';

class ProviderRequestsRepository {
  final ApiService _apiService = ApiService();

  /// Fetch provider requests with optional search and sort
  Future<List<ProviderRequest>> fetchProviderRequests({
    String? search,
    String? sort, // "oldest" or "latest"
  }) async {
    try {
      // Build query params
      final queryParams = <String, String>{};
      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (sort != null && sort.isNotEmpty) queryParams['sort'] = sort;

      final response = await _apiService.get(
        ApiEndpoints.providerRequests,
        queryParams: queryParams,
      );

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
