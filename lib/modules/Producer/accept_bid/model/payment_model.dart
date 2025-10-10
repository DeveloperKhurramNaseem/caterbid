class PaymentModel {
  final String title;
  final String location;
  final String date;
  final double subtotal;
  final double platformFee;

  PaymentModel({
    required this.title,
    required this.location,
    required this.date,
    required this.subtotal,
    required this.platformFee,
  });
}
