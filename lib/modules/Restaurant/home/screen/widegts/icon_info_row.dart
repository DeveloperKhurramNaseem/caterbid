import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class IconInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconInfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = Responsive.responsiveSize(context, 12, 13, 14);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: Responsive.responsiveSize(context, 16, 18, 20),
          color: AppColors.icon,
        ),
        SizedBox(width: Responsive.responsiveSize(context, 6, 8, 10)),
        Text(text, style: TextStyle(fontSize: size, color: Colors.black54)),
      ],
    );
  }
}
