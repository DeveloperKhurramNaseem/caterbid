import 'package:equatable/equatable.dart';

class RequesteeModel extends Equatable {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? profilePicture;
  final String? email;

  const RequesteeModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.profilePicture,
    this.email,
  });

  String get firstLetter => name?.isNotEmpty == true ? name![0].toUpperCase() : '?';

  RequesteeModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? profilePicture,
    String? email,
  }) {
    return RequesteeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      email: email ?? this.email,
    );
  }

factory RequesteeModel.fromJson(Map<String, dynamic> json) {
  String? pic = json['profilePicture']?.toString();

  // Only prepend base URL if it is not already absolute
  if (pic != null && pic.isNotEmpty && !pic.startsWith('http')) {
    pic = 'https://api.cater-bid.com$pic';
  }

  return RequesteeModel(
    id: json['_id']?.toString(),
    name: json['name']?.toString(),
    phoneNumber: json['phoneNumber']?.toString(),
    profilePicture: pic,
    email: json['email']?.toString(),
  );
}


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'email': email,
    };
  }

  Map<String, String> toFields() => {
        if (name != null) 'name': name!,
        if (phoneNumber != null) 'phoneNumber': phoneNumber!,
      };

  @override
  List<Object?> get props => [id, name, phoneNumber, profilePicture, email];
}