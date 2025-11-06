import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'payment_row.dart';

class PaymentDetails extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final double amount;

  const PaymentDetails({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final fontTitle = Responsive.responsiveSize(context, 18, 20, 22);
    final fontSub = Responsive.responsiveSize(context, 14, 15, 16);

    final subtotal = amount;
    final platformFee = subtotal * 0.05; // Example: 5% platform fee
    final total = subtotal + platformFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontTitle,
                  color: AppColors.textDark,
                )),
            Text(date,
                style: TextStyle(
                  fontSize: fontSub,
                  color: AppColors.textDark.withOpacity(0.7),
                )),
          ],
        ),
        const SizedBox(height: 4),
        Text(location,
            style: TextStyle(
              fontSize: fontSub,
              color: AppColors.textDark.withOpacity(0.7),
            )),
        const SizedBox(height: 25),
        PaymentRow(title: "Subtotal", amount: subtotal),
        const SizedBox(height: 10),
        PaymentRow(title: "Platform Fee", amount: platformFee),
        const SizedBox(height: 10),
        PaymentRow(title: "Total", amount: total, isTotal: true),
      ],
    );
  }
}
