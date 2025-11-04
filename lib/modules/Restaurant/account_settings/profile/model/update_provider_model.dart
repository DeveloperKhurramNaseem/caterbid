import 'dart:io';

import 'package:caterbid/modules/Restaurant/account_settings/profile/model/provider_profile_model.dart';

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

  // NEW – human readable address (only for UI)
  final String? formattedAddress;

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
    this.formattedAddress,
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

  factory UpdateProviderModel.fromProviderModel(ProviderModel model) {
    return UpdateProviderModel(
      name: model.name ?? '',
      companyName: model.companyName ?? '',
      businessType: model.businessType ?? '',
      description: model.description ?? '',
      phoneNumber: model.phoneNumber ?? '',
      lat: model.latitude ?? 37.7749,
      lng: model.longitude ?? -122.4194,
      profilePicture: model.profilePicture,
    );
  }
}