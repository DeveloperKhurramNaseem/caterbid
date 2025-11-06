import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class MyBidSection extends StatelessWidget {
  final String amount;
  final String? description;

  const MyBidSection({
    super.key,
    required this.amount,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final double h = Responsive.height(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: h * 0.01),

        Text(
          'My Bid Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Responsive.responsiveSize(context, 13, 14, 15),
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: h * 0.005),

        if (description != null)
          Text(
            description!,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: Responsive.responsiveSize(context, 12, 13, 14),
            ),
          ),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            amount,
            style: TextStyle(
              color: AppColors.icon,
              fontWeight: FontWeight.w700,
              fontSize: Responsive.responsiveSize(context, 16, 17, 19),
            ),
          ),
        ),
        SizedBox(height: h * 0.02),
      ],
    );
  }
}