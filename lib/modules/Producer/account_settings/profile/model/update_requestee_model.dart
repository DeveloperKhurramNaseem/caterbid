import 'dart:io';

class UpdateRequesteeModel {
  final String name;
  final String phoneNumber;
  final File? file; // file to upload
  final String? profilePicture; // server URL after update

  UpdateRequesteeModel({
    required this.name,
    required this.phoneNumber,
    this.file,
    this.profilePicture,
  });

  Map<String, String> toFields() => {
        'name': name,
        'phoneNumber': phoneNumber,
      };

  factory UpdateRequesteeModel.fromJson(Map<String, dynamic> json) {
    return UpdateRequesteeModel(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] != null
          ? 'https://api.cater-bid.com${json['profilePicture']}'
          : null,
    );
  }
}
