import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter/material.dart';

import 'payment_row.dart';
import '../../model/payment_model.dart';

class PaymentDetails extends StatelessWidget {
  final PaymentModel payment;

  const PaymentDetails({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final fontTitle = Responsive.responsiveSize(context, 18, 20, 22);
    final fontSub = Responsive.responsiveSize(context, 14, 15, 16);

    final total = payment.subtotal + payment.platformFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              payment.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontTitle,
                color: AppColors.textDark,
              ),
            ),
            Text(
              payment.date,
              style: TextStyle(
                fontSize: fontSub,
                color: AppColors.textDark.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          payment.location,
          style: TextStyle(
            fontSize: fontSub,
            color: AppColors.textDark.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 25),

        PaymentRow(title: "Subtotal", amount: payment.subtotal),
        const SizedBox(height: 10),
        PaymentRow(title: "Platform Fee", amount: payment.platformFee),
        const SizedBox(height: 10),
        PaymentRow(title: "Total", amount: total, isTotal: true),
      ],
    );
  }
}
