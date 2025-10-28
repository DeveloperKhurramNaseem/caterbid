class RequesteeChangePasswordRequest {
  final String currentPassword;
  final String newPassword;

  RequesteeChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      };
}
