// models/requests_model.dart
class RequestLocation {
  final double longitude;
  final double latitude;

  RequestLocation({
    required this.longitude,
    required this.latitude,
  });

  factory RequestLocation.fromJson(Map<String, dynamic> json) {
    final coords = (json['coordinates'] as List?)?.cast<dynamic>() ?? [];
    final lng = coords.isNotEmpty ? (coords[0] as num).toDouble() : 0.0;
    final lat = coords.length > 1 ? (coords[1] as num).toDouble() : 0.0;

    // Note: coordinates are [longitude, latitude]
    return RequestLocation(latitude: lat, longitude: lng);
  }
}

class Requestee {
  final String id;
  final String name;

  Requestee({required this.id, required this.name});

  factory Requestee.fromJson(Map<String, dynamic> json) {
    return Requestee(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class ProviderRequest {
  final String id;
  final RequestLocation location;
  final Requestee? requestee;
  final String title;
  final String? description;
  final int budgetCents;
  final int budgetDollars;
  final String currency;
  final int numPeople;
  final DateTime date;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? acceptedBidId;
  final String? address;

  ProviderRequest({
    required this.id,
    required this.location,
    this.requestee,
    required this.title,
    this.description,
    required this.budgetCents,
    required this.budgetDollars,
    required this.currency,
    required this.numPeople,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.address,
    this.acceptedBidId,
  });

  factory ProviderRequest.fromJson(Map<String, dynamic> json) {
    return ProviderRequest(
      id: json['_id'] ?? '',
      location: RequestLocation.fromJson(json['location'] ?? {}),
      requestee: json['requesteeId'] != null
          ? Requestee.fromJson(json['requesteeId'])
          : null,
      title: json['title'] ?? '',
      description: json['description'],
      budgetCents: (json['budgetCents'] ?? 0).toInt(),
      budgetDollars: (json['budgetDollars'] ?? 0).toInt(),
      currency: json['currency'] ?? '',
      numPeople: (json['numPeople'] ?? 0).toInt(),
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      acceptedBidId: json['acceptedBidId'], 
      address: json['address'],
    );
  }
}
