class LoginResponseModel {
  final String id;
  final String role;
  final String email;
  final String token;
  final bool locationRequired;

  const LoginResponseModel({
    required this.id,
    required this.role,
    required this.email,
    required this.token,
    required this.locationRequired,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['_id'],
      role: json['role'],
      email: json['email'],
      token: json['token'],
      locationRequired: json['locationRequired'] ?? false,
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "_id": id,
  //       "role": role,
  //       "email": email,
  //       "token": token,
  //       "locationRequired": locationRequired,
  //     };
}
