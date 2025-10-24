class BidModel {
  final String id;
  final BidRequest request;
  final BidProvider provider;
  final int amountCents;
  final int amountDollars;
  final String currency;
  final String description;
  final String? attachment; 
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  BidModel({
    required this.id,
    required this.request,
    required this.provider,
    required this.amountCents,
    required this.amountDollars,
    required this.currency,
    required this.description,
    this.attachment, 
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['_id'] ?? '',
      request: BidRequest.fromJson(json['requestId'] ?? {}),
      provider: BidProvider.fromJson(json['providerId'] ?? {}),
      amountCents: json['amountCents'] ?? 0,
      amountDollars: json['amountDollars'] ?? 0,
      currency: json['currency'] ?? '',
      description: json['description'] ?? '',
      attachment: json['attachment'], 
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}


class BidRequest {
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
  final BidLocation? location;
  final BidRequestee? requestee;

  BidRequest({
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
    this.location,
    this.requestee,
  });

  factory BidRequest.fromJson(Map<String, dynamic> json) {
    return BidRequest(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      budgetCents: json['budgetCents'] ?? 0,
      budgetDollars: json['budgetDollars'] ?? 0,
      currency: json['currency'] ?? '',
      numPeople: json['numPeople'] ?? 0,
      status: json['status'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      location: json['location'] != null
          ? BidLocation.fromJson(json['location'])
          : null,
      requestee: json['requesteeId'] != null
          ? BidRequestee.fromJson(json['requesteeId'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "budgetCents": budgetCents,
        "budgetDollars": budgetDollars,
        "currency": currency,
        "numPeople": numPeople,
        "status": status,
        "date": date.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "location": location?.toJson(),
        "requesteeId": requestee?.toJson(),
      };
}

class BidProvider {
  final String id;
  final String name;
  final String companyName;

  BidProvider({
    required this.id,
    required this.name,
    required this.companyName,
  });

  factory BidProvider.fromJson(Map<String, dynamic> json) {
    return BidProvider(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      companyName: json['companyName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "companyName": companyName,
      };
}

class BidRequestee {
  final String id;
  final String name;

  BidRequestee({
    required this.id,
    required this.name,
  });

  factory BidRequestee.fromJson(Map<String, dynamic> json) {
    return BidRequestee(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

/// Location model (used in request)
class BidLocation {
  final String type;
  final List<double> coordinates;

  BidLocation({
    required this.type,
    required this.coordinates,
  });

  factory BidLocation.fromJson(Map<String, dynamic> json) {
    return BidLocation(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates,
      };
}
