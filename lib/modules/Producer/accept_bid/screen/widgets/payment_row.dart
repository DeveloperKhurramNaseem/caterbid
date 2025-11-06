import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:flutter/material.dart';

class PaymentRow extends StatelessWidget {
  final String title;
  final double amount;
  final bool isTotal;

  const PaymentRow({
    super.key,
    required this.title,
    required this.amount,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final font = Responsive.responsiveSize(context, 15, 16, 17);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: font,
            color: AppColors.textDark,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(1)}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: font,
            color: isTotal ? Colors.orange : Colors.orange.shade700,
          ),
        ),
      ],
    );
  }
}
