class LoginResponseModel {
  final String id;
  final String role;
  final String email;
  final String token;

  const LoginResponseModel({
    required this.id,
    required this.role,
    required this.email,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['_id'],
      role: json['role'],
      email: json['email'],
      token: json['token'],
    );
  }
}
