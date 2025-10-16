class SignUpRequestModel {
  final String role;
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  final String? companyName;

  SignUpRequestModel({
    required this.role,
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
    this.companyName,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "role": role,
      "email": email,
      "password": password,
      "name": name,
      "phoneNumber": phoneNumber,
    };

    // Only include `companyName` for providers
    if (role == "provider" && companyName != null && companyName!.isNotEmpty) {
      data["companyName"] = companyName;
    }

    return data;
  }
}
