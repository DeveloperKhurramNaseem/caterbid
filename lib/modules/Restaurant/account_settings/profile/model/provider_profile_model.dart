import 'package:equatable/equatable.dart';

class ProviderModel extends Equatable {
  final String? id;
  final String? name;
  final String? companyName;
  final String? businessType;
  final String? description;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;
  final bool? isVerified;
  final double? latitude;
  final double? longitude;
  

  const ProviderModel({
    this.id,
    this.name,
    this.companyName,
    this.businessType,
    this.description,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.isVerified,
    this.latitude,
    this.longitude,
  });

  String get firstLetter => name?.isNotEmpty == true ? name![0].toUpperCase() : '?';

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'];
    final coordinates = location != null && location['coordinates'] != null
        ? List<double>.from(location['coordinates'].map((x) => x.toDouble()))
        : [0.0, 0.0];

    String? pic = json['profilePicture']?.toString();
    if (pic != null && pic.isNotEmpty && !pic.startsWith('http')) {
      pic = 'https://api.cater-bid.com$pic';
    }

    return ProviderModel(
      id: json['_id']?.toString(),
      name: json['name']?.toString(),
      companyName: json['companyName']?.toString(),
      businessType: json['businessType']?.toString(),
      description: json['description']?.toString(),
      email: json['email']?.toString(),
      phoneNumber: json['phoneNumber']?.toString(),
      profilePicture: pic,
      isVerified: json['isverified'] ?? false,
      latitude: coordinates.isNotEmpty ? coordinates[1] : -122.4194,
      longitude: coordinates.isNotEmpty ? coordinates[0] : 37.7749,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'companyName': companyName,
        'businessType': businessType,
        'description': description,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'isverified': isVerified,
        'location': {
          'type': 'Point',
          'coordinates': [longitude, latitude],
        },
      };

  Map<String, String> toFields() => {
        if (name != null) 'name': name!,
        if (companyName != null) 'companyName': companyName!,
        if (businessType != null) 'businessType': businessType!,
        if (description != null) 'description': description!,
        if (phoneNumber != null) 'phoneNumber': phoneNumber!,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        companyName,
        businessType,
        description,
        email,
        phoneNumber,
        profilePicture,
        isVerified,
        latitude,
        longitude,
      ];
}

extension ProviderModelCopy on ProviderModel {
  ProviderModel copyWith({
    double? latitude,
    double? longitude,
  }) {
    return ProviderModel(
      id: id,
      name: name,
      companyName: companyName,
      businessType: businessType,
      description: description,
      email: email,
      phoneNumber: phoneNumber,
      profilePicture: profilePicture,
      isVerified: isVerified,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
