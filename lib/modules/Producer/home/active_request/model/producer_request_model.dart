class ProducerRequest {
  final String id;
  final String title;
  final int budgetCents;
  final int budgetDollars;
  final String currency;
  final int numPeople;
  final String status;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Requestee requestee;
  final Location location;

  ProducerRequest({
    required this.id,
    required this.title,
    required this.budgetCents,
    required this.budgetDollars,
    required this.currency,
    required this.numPeople,
    required this.status,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.requestee,
    required this.location,
  });

  factory ProducerRequest.fromJson(Map<String, dynamic> json) {
    return ProducerRequest(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      budgetCents: json['budgetCents'] ?? 0,
      budgetDollars: json['budgetDollars'] ?? 0,
      currency: json['currency'] ?? '',
      numPeople: json['numPeople'] ?? 0,
      status: json['status'] ?? '',
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      requestee: Requestee.fromJson(json['requesteeId'] ?? {}),
      location: Location.fromJson(json['location'] ?? {}),
    );
  }

  factory ProducerRequest.empty() => ProducerRequest(
    id: '',
    title: '',
    budgetCents: 0,
    budgetDollars: 0,
    currency: '',
    numPeople: 0,
    status: '',
    date: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    requestee: Requestee(id: '', name: ''),
    location: Location(type: '', coordinates: []),
  );

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'budgetCents': budgetCents,
      'budgetDollars': budgetDollars,
      'currency': currency,
      'numPeople': numPeople,
      'status': status,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'requesteeId': requestee.toJson(),
      'location': location.toJson(),
    };
  }
}

class Requestee {
  final String id;
  final String name;

  Requestee({required this.id, required this.name});

  factory Requestee.fromJson(Map<String, dynamic> json) {
    return Requestee(id: json['_id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name};
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    final coords =
        (json['coordinates'] as List?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];
    return Location(type: json['type'] ?? '', coordinates: coords);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'coordinates': coordinates};
  }

  ///helper to safely return a formatted string
  String get formattedCoordinates {
    if (coordinates.length >= 2) {
      final lat = coordinates[1];
      final lng = coordinates[0];
      return "Lat: ${lat.toStringAsFixed(4)}, Lng: ${lng.toStringAsFixed(4)}";
    }
    return "Location not available";
  }
}

extension ProducerRequestHelpers on ProducerRequest {
  String get formattedLocation => location.formattedCoordinates;
}
