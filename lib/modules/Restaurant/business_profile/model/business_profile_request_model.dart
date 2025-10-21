class BusinessProfileRequestModel {
  final String companyName;
  final String businessType;
  final String description;
  final String phoneNumber;
  final double lat;
  final double lng;

  BusinessProfileRequestModel({
    required this.companyName,
    required this.businessType,
    required this.description,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      "companyName": companyName,
      "businessType": businessType,
      "description": description,
      "phoneNumber": phoneNumber,
      "lat": lat,
      "lng": lng,
    };
  }
}
