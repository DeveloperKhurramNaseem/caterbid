import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/core/config/app_colors.dart';

class ProducerRequestCardShimmer extends StatelessWidget {
  const ProducerRequestCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1200), // smooth speed
      child: Container(
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Title Placeholder ---
            Container(
              height: h * 0.02,
              width: w * 0.4,
              color: Colors.white,
            ),
            SizedBox(height: h * 0.015),

            // --- Request title ---
            Container(
              height: h * 0.022,
              width: w * 0.6,
              color: Colors.white,
            ),
            SizedBox(height: h * 0.01),

            // --- Location ---
            Container(
              height: h * 0.018,
              width: w * 0.5,
              color: Colors.white,
            ),
            SizedBox(height: h * 0.01),

            // --- Date ---
            Container(
              height: h * 0.018,
              width: w * 0.4,
              color: Colors.white,
            ),
            SizedBox(height: h * 0.02),

            // --- Budget and People Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: h * 0.02,
                  width: w * 0.25,
                  color: Colors.white,
                ),
                Container(
                  height: h * 0.02,
                  width: w * 0.25,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
