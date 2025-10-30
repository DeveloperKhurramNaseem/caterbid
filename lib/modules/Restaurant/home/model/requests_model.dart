// models/requests_model.dart
class RequestLocation {
  final double longitude;
  final double latitude;

  RequestLocation({required this.longitude, required this.latitude});

  factory RequestLocation.fromJson(Map<String, dynamic> json) {
    final coords = json['coordinates'] as List<dynamic>;
    return RequestLocation(
      longitude: (coords[0] as num).toDouble(),
      latitude: (coords[1] as num).toDouble(),
    );
  }
}

class Requestee {
  final String id;
  final String name;

  Requestee({required this.id, required this.name});

  factory Requestee.fromJson(Map<String, dynamic> json) {
    return Requestee(
      id: json['_id'] as String,
      name: json['name'] as String,
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
    this.acceptedBidId,
  });

  factory ProviderRequest.fromJson(Map<String, dynamic> json) {
    return ProviderRequest(
      id: json['_id'] as String,
      location: RequestLocation.fromJson(json['location']),
      requestee: json['requesteeId'] != null
          ? Requestee.fromJson(json['requesteeId'])
          : null,
      title: json['title'] as String,
      description: json['description'] as String?,
      budgetCents: (json['budgetCents'] as num).toInt(),
      budgetDollars: (json['budgetDollars'] as num).toInt(),
      currency: json['currency'] as String,
      numPeople: (json['numPeople'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      acceptedBidId: json['acceptedBidId'] as String?,
    );
  }
}