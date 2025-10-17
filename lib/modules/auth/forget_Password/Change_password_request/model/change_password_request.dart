class ChangePasswordRequest {
  final String email;
  final String newPassword;

  ChangePasswordRequest({required this.email, required this.newPassword});

  Map<String, dynamic> toJson() => {
        'email': email,
        'newPassword': newPassword,
      };
}
