import 'package:caterbid/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class PlaceBidButton extends StatelessWidget {
  const PlaceBidButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.responsiveSize(context, 48, 52, 56),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.c500,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          "Place Bid",
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.responsiveSize(context, 16, 18, 20),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
