import 'package:caterbid/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class LocationField extends StatelessWidget {
  const LocationField({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = Responsive.responsiveSize(context, 14, 16, 18);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Choose from Map',
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.icon,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
