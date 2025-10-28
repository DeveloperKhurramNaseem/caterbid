import 'dart:io';

class UpdateProviderModel {
  final String name;
  final String companyName;
  final String businessType;
  final String description;
  final String phoneNumber;
  final double lat;
  final double lng;
  final File? file;
  final String? profilePicture;

  UpdateProviderModel({
    required this.name,
    required this.companyName,
    required this.businessType,
    required this.description,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
    this.file,
    this.profilePicture,
  });

  Map<String, String> toFields() => {
        'name': name,
        'companyName': companyName,
        'businessType': businessType,
        'description': description,
        'phoneNumber': phoneNumber,
        'lat': lat.toString(),
        'lng': lng.toString(),
      };

  factory UpdateProviderModel.fromJson(Map<String, dynamic> json) {
    // Default coordinates (San Francisco for example)
    const defaultLat = 37.7749;
    const defaultLng = -122.4194;

    final coords = json['location']?['coordinates'];
    double lng = defaultLng;
    double lat = defaultLat;

    if (coords is List && coords.length == 2) {
      // GeoJSON uses [longitude, latitude]
      lng = (coords[0] is num) ? coords[0].toDouble() : defaultLng;
      lat = (coords[1] is num) ? coords[1].toDouble() : defaultLat;
    }

    return UpdateProviderModel(
      name: json['name'] ?? '',
      companyName: json['companyName'] ?? '',
      businessType: json['businessType'] ?? '',
      description: json['description'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      lat: lat,
      lng: lng,
      profilePicture: json['profilePicture'] != null
          ? 'https://api.cater-bid.com${json['profilePicture']}'
          : null,
    );
  }
}
