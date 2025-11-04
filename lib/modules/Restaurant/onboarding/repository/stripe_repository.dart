import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/Restaurant/onboarding/model/stripe_connect_response.dart';

class StripeRepository {
  final ApiService apiService;

  StripeRepository({required this.apiService});

  /// Get Stripe Connect Onboarding Link
  Future<StripeConnectResponse> getConnectLink() async {
    final response = await apiService.put(ApiEndpoints.providerOnboarding, {});
    // response expected:
    // { "success": true, "url": "...", "accountId": "..." }
    return StripeConnectResponse.fromJson(response);
  }

  /// Check Stripe Account Status
  Future<StripeStatusResponse> checkStatus(String accountId) async {
    final response = await apiService.get("${ApiEndpoints.getAccountStatus}?accountId=$accountId");
    // response expected:
    // { "success": true, "onboarded": false, "charges_enabled": false, ... }
    return StripeStatusResponse.fromJson(response);
  }
}
