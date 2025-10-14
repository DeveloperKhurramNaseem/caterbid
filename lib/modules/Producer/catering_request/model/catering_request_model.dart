class CateringRequestModel {
  final String title;
  final int budgetCents;
  final String currency;
  final int peopleCount;
  final DateTime date;
  final double lat;
  final double lng;
  final String? specialInstructions;

  CateringRequestModel({
    required this.title,
    required this.budgetCents,
    required this.currency,
    required this.peopleCount,
    required this.date,
    required this.lat,
    required this.lng,
    this.specialInstructions,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'budgetCents': budgetCents,
        'currency': currency,
        'peopleCount': peopleCount,
        'date': date.toIso8601String(),
        'location': {'lat': lat, 'lng': lng},
        'specialInstructions': specialInstructions,
      };
}
