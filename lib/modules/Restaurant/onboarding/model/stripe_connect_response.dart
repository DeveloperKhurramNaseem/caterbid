// models/stripe_model.dart
class StripeConnectResponse {
  final bool success;
  final String url;
  final String accountId;

  StripeConnectResponse({
    required this.success,
    required this.url,
    required this.accountId,
  });

  factory StripeConnectResponse.fromJson(Map<String, dynamic> json) {
    return StripeConnectResponse(
      success: json['success'] ?? false,
      url: json['url'] ?? '',
      accountId: json['accountId'] ?? '',
    );
  }
}

class StripeStatusResponse {
  final bool success;
  final bool onboarded;
  final bool chargesEnabled;
  final bool payoutsEnabled;
  final String accountId;

  StripeStatusResponse({
    required this.success,
    required this.onboarded,
    required this.chargesEnabled,
    required this.payoutsEnabled,
    required this.accountId,
  });

  factory StripeStatusResponse.fromJson(Map<String, dynamic> json) {
    return StripeStatusResponse(
      success: json['success'] ?? false,
      onboarded: json['onboarded'] ?? false,
      chargesEnabled: json['charges_enabled'] ?? false,
      payoutsEnabled: json['payouts_enabled'] ?? false,
      accountId: json['accountId'] ?? '',
    );
  }

  bool get isConnected => success && onboarded && chargesEnabled && payoutsEnabled;
}
