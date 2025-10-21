class EmailNotVerifiedModel {
  final String email;
  final String error;
  final String role;

  EmailNotVerifiedModel({
    required this.email,
    required this.error,
    required this.role,
  });

  factory EmailNotVerifiedModel.fromJson(Map<String, dynamic> json, String email) {
    return EmailNotVerifiedModel(
      email: email, // comes from request model
      error: json['error'] ?? "Email not verified",
      role: json['role'] ?? "unknown", 
    );
  }
}
