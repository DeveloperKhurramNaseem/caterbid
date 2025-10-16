import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class ProducerBidCardShimmer extends StatelessWidget {
  const ProducerBidCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1200),
      child: Container(
        margin: EdgeInsets.only(bottom: h * 0.015),
        padding: EdgeInsets.all(w * 0.035),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Top Row: Image + Info ---
            Row(
              children: [
                // Image placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: h * 0.08,
                    width: h * 0.08,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: w * 0.03),

                // Text placeholders
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: h * 0.02,
                        width: w * 0.4,
                        color: Colors.white,
                      ),
                      SizedBox(height: h * 0.008),
                      Container(
                        height: h * 0.018,
                        width: w * 0.3,
                        color: Colors.white,
                      ),
                      SizedBox(height: h * 0.008),
                      Container(
                        height: h * 0.018,
                        width: w * 0.35,
                        color: Colors.white,
                      ),
                      SizedBox(height: h * 0.008),
                      Container(
                        height: h * 0.018,
                        width: w * 0.4,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: h * 0.015),

            /// --- Description placeholder ---
            Container(
              height: h * 0.045,
              width: double.infinity,
              color: Colors.white,
            ),
            SizedBox(height: h * 0.015),

            /// --- Attached menu text placeholder ---
            Container(
              height: h * 0.018,
              width: w * 0.3,
              color: Colors.white,
            ),
            SizedBox(height: h * 0.02),

            /// --- Button placeholder ---
            Container(
              width: double.infinity,
              height: h * 0.055,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
