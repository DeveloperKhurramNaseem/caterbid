import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/config/app_colors.dart';

class StatusTag extends StatelessWidget {
  final String status;

  const StatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final double height = Responsive.responsiveSize(context, 22, 22, 24);
    final double width = Responsive.responsiveSize(context, 61, 65, 70);
    final double fontSize = Responsive.responsiveSize(context, 12, 13, 14);

    final bool isActive = status.toLowerCase() == 'active';

    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.icon,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isActive ? 'Active' : 'Fulfilled',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ),
      
    );
    
  }
}

