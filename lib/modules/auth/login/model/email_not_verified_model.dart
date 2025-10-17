class EmailNotVerifiedModel {
  final String email;
  final String error;

  EmailNotVerifiedModel({
    required this.email,
    required this.error,
  });

  factory EmailNotVerifiedModel.fromJson(Map<String, dynamic> json, String email) {
    return EmailNotVerifiedModel(
      email: email,
      error: json['error'] ?? "Email not verified",
    );
  }
}

