class ProviderChangePasswordRequest {
  final String currentPassword;
  final String newPassword;

  ProviderChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      };
}
