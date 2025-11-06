class ProviderMyBidsModel {
  final String id;
  final RequestDetail request;
  final String providerId;
  final int amountCents;
  final int amountDollars;
  final String currency;
  final String? description;
  final String? attachment;
  final String status;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  ProviderMyBidsModel({
    required this.id,
    required this.request,
    required this.providerId,
    required this.amountCents,
    required this.amountDollars,
    required this.currency,
    this.description,
    this.attachment,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ProviderMyBidsModel.fromJson(Map<String, dynamic> json) {
    return ProviderMyBidsModel(
      id: json['_id'] ?? '',
      request: RequestDetail.fromJson(json['requestId'] ?? {}),
      providerId: json['providerId'] ?? '',
      amountCents: json['amountCents'] ?? 0,
      amountDollars: json['amountDollars'] ?? 0,
      currency: json['currency'] ?? '',
      description: json['description'],
      attachment: json['attachment'],
      status: json['status'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'requestId': request.toJson(),
      'providerId': providerId,
      'amountCents': amountCents,
      'amountDollars': amountDollars,
      'currency': currency,
      'description': description,
      'attachment': attachment,
      'status': status,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class RequestDetail {
  final String id;
  final String title;
  final int numPeople;
  final DateTime date;
  final String status;
  final bool isDeleted;
  final Location location;
  final String requesteeName;
  final int budgetDollars;
  final String? address; // <-- NEW

  RequestDetail({
    required this.id,
    required this.title,
    required this.numPeople,
    required this.date,
    required this.status,
    required this.isDeleted,
    required this.location,
    required this.requesteeName,
    required this.budgetDollars,
    this.address, // <-- NEW
  });

  factory RequestDetail.fromJson(Map<String, dynamic> json) {
    return RequestDetail(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      numPeople: json['numPeople'] ?? 0,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      location: Location.fromJson(json['location'] ?? {}),
      requesteeName: json['requesteeId']?['name'] ?? 'Unknown',
      budgetDollars: json['budgetDollars'] ?? 0,
      address: json['address'], // <-- NEW
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'numPeople': numPeople,
      'date': date.toIso8601String(),
      'status': status,
      'isDeleted': isDeleted,
      'location': location.toJson(),
      'requesteeName': requesteeName,
      'budgetDollars': budgetDollars,
      'address': address, // <-- NEW
    };
  }
}


class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
