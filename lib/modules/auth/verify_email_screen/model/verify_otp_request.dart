class VerifyOtpRequestModel {
  final String role;
  final String email;
  final String otp;

  VerifyOtpRequestModel({
    required this.role,
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'role': role,
        'email': email,
        'otp': otp,
      };
}

