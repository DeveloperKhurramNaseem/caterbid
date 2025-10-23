import 'dart:io';

class PlaceBidRequest {
  final String requestId;
  final String amount;
  final String currency;
  final String description;
  final File? attachment;

  PlaceBidRequest({
    required this.requestId,
    required this.amount,
    required this.currency,
    required this.description,
    this.attachment,
  });

  /// Converts to Map for fields (multipart form-data)
  Map<String, String> toFields() {
    return {
      'requestId': requestId,
      'amount': amount,
      'currency': currency,
      'description': description,
    };
  }
}
