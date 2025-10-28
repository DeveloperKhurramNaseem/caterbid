class VerifyOtpResponseModel {
  final String id;
  final String email;
  final String role;
  final String token;
  final bool locationRequired;


  const VerifyOtpResponseModel({
    required this.id,
    required this.email,
    required this.role,
    required this.token,
    required this.locationRequired,

  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      token: json['token'] ?? '',
      locationRequired: json['locationRequired'] ?? false,

    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'email': email,
        'role': role,
        'token': token,
        'locationRequired': locationRequired,

      };
}
