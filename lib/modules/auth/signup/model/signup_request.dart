class SignUpRequestModel {
  final String role;
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  final String? companyName;
  // final double? lat;
  // final double? lng;

  SignUpRequestModel({
    required this.role,
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
    this.companyName,
    // this.lat,
    // this.lng,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "role": role,
      "email": email,
      "password": password,
      "name": name,
      "phoneNumber": phoneNumber,
    };

    if (role == "provider") {
      data["companyName"] = companyName;
      // data["location"] = {"lat": lat, "lng": lng};
    }

    return data;
  }
}
