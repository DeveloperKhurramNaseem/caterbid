import 'dart:io';

class PlaceBidRequest {
  final String requestId;
  final String amount;
  final String currency;
  final String? description;
  final File? attachment;

  PlaceBidRequest({
    required this.requestId,
    required this.amount,
    required this.currency,
    this.description, // Made optional
    this.attachment,
  });

  /// Converts to Map for fields (multipart form-data)
  Map<String, String> toFields() {
    final fields = {
      'requestId': requestId,
      'amount': amount,
      'currency': currency,
    };
    if (description != null) {
      fields['description'] = description!;
    }
    return fields;
  }
}