// models/formatted_request_model.dart
import 'requests_model.dart';

class FormattedProviderRequest {
  final String id;
  final RequestLocation location;
  final Requestee? requestee;
  final String title;
  final String? description;
  final String formattedPrice;
  final String formattedDate;
  final String formattedTime;
  final String formattedPeople;
  final String formattedLocation;
  final DateTime rawDate;
  final int numPeople;
  final String status;
  final DateTime createdAt;
  final String currency; // ADD THIS


  FormattedProviderRequest({
    required this.id,
    required this.location,
    this.requestee,
    required this.title,
    this.description,
    required this.formattedPrice,
    required this.formattedDate,
    required this.formattedTime,
    required this.formattedPeople,
    required this.formattedLocation,
    required this.rawDate,
    required this.numPeople,
    required this.status,
    required this.createdAt,
    required this.currency,
  });
}