import 'package:equatable/equatable.dart';

class BidModel extends Equatable {
  final String id;
  final Request request;
  final String providerId;
  final int amountCents;
  final int amountDollars;
  final String currency;
  final String? description;
  final String? attachment;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BidModel({
    required this.id,
    required this.request,
    required this.providerId,
    required this.amountCents,
    required this.amountDollars,
    required this.currency,
    this.description,
    this.attachment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['_id'] as String,
      request: Request.fromJson(json['requestId'] as Map<String, dynamic>),
      providerId: json['providerId'] as String,
      amountCents: json['amountCents'] as int,
      amountDollars: json['amountDollars'] as int,
      currency: json['currency'] as String,
      description: json['description'] as String?,
      attachment: json['attachment'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        request,
        providerId,
        amountCents,
        amountDollars,
        currency,
        description,
        attachment,
        status,
        createdAt,
        updatedAt,
      ];
}

class Request extends Equatable {
  final String id;
  final String title;
  final DateTime? date;
  final String status;
  final Location? location;

  const Request({
    required this.id,
    required this.title,
    this.date,
    required this.status,
    this.location,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['_id'] as String,
      title: json['title'] as String,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      status: json['status'] as String,
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [id, title, date, status, location];
}

class Location extends Equatable {
  final String type;
  final List<double> coordinates;

  const Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>).cast<double>(),
    );
  }

  double get latitude => coordinates[1];
  double get longitude => coordinates[0];

  @override
  List<Object?> get props => [type, coordinates];
}