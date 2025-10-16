class CateringRequestModel {
  final String title;
  final int budget;
  final String currency;
  final int peopleCount;
  final DateTime date;
  final double lat;
  final double lng;
  final String? specialInstructions;

  CateringRequestModel({
    required this.title,
    required this.budget,
    required this.currency,
    required this.peopleCount,
    required this.date,
    required this.lat,
    required this.lng,
    this.specialInstructions,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "budget": budget,
        "currency": currency,
        "peopleCount": peopleCount,
        "date": date.toIso8601String(),
        "location": {"lat": lat, "lng": lng},
        if (specialInstructions != null)
          "specialInstructions": specialInstructions,
      };
}
