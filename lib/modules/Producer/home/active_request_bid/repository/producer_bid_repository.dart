import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/model/producer_bid_model.dart';

class BidsRepository {
  final ApiService _apiService = ApiService();

  Future<List<BidModel>> fetchBidsByRequestId(String requestId) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.getActiveRequestBids(requestId),
      );

      if (response is List) {
        return response
            .map((item) => BidModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(message: 'Invalid response format: Expected a list');
      }
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
