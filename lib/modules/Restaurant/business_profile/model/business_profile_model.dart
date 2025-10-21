class BusinessProfileResponse {
  final String message;
  final ProviderProfile provider;

  BusinessProfileResponse({
    required this.message,
    required this.provider,
  });

  factory BusinessProfileResponse.fromJson(Map<String, dynamic> json) {
    return BusinessProfileResponse(
      message: json['message'] ?? '',
      provider: ProviderProfile.fromJson(json['provider']),
    );
  }
}

class ProviderProfile {
  final String id;
  final String name;
  final String companyName;
  final String email;
  final String phoneNumber;
  final bool isVerified;
  final String businessType;
  final String description;
  final double lat;
  final double lng;

  ProviderProfile({
    required this.id,
    required this.name,
    required this.companyName,
    required this.email,
    required this.phoneNumber,
    required this.isVerified,
    required this.businessType,
    required this.description,
    required this.lat,
    required this.lng,
  });

  factory ProviderProfile.fromJson(Map<String, dynamic> json) {
    final coordinates = json['location']?['coordinates'] ?? [0.0, 0.0];
    return ProviderProfile(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      companyName: json['companyName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      isVerified: json['isverified'] ?? false,
      businessType: json['businessType'] ?? '',
      description: json['description'] ?? '',
      lng: (coordinates[0] ?? 0).toDouble(),
      lat: (coordinates[1] ?? 0).toDouble(),
    );
  }
}
