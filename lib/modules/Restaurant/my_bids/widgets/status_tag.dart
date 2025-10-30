import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class StatusTag extends StatelessWidget {
  final String status;

  const StatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final bool isActive = status == 'Active';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSize(context, 10, 12, 14),
        vertical: Responsive.responsiveSize(context, 4, 5, 6),
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.icon : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: Colors.white,
          fontSize: Responsive.responsiveSize(context, 11, 12, 13),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}