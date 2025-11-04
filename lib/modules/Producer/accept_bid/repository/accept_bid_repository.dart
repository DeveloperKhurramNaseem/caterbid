import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';

class AcceptBidRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> acceptBid({
    required String requestId,
    required String bidId,
  }) async {
    try {
      print('Attempting to accept bid: $bidId for request: $requestId');

      final response = await _apiService.put(
        ApiEndpoints.acceptBidForRequest(requestId, bidId),
        {},
      );

      print('Response: $response');

      return response;
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
