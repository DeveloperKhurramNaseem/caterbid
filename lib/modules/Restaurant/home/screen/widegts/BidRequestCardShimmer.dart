import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class BidRequestCardShimmer extends StatelessWidget {
  
  const BidRequestCardShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    final pad = Responsive.responsiveSize(context, 12, 16, 20);

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(pad),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top row (title + price)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(context, width: 150, height: 20),
                _shimmerBox(context, width: 60, height: 20),
              ],
            ),
            SizedBox(height: Responsive.responsiveSize(context, 6, 8, 10)),

            _shimmerBox(context, width: 120, height: 14), // posted by
            SizedBox(height: Responsive.responsiveSize(context, 10, 12, 14)),

            // icons info
            Wrap(
              runSpacing: 6,
              spacing: 12,
              children: List.generate(
                4,
                (_) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _circleShimmer(context, size: 16),
                    SizedBox(width: Responsive.responsiveSize(context, 6, 8, 10)),
                    _shimmerBox(context, width: 60, height: 12),
                  ],
                ),
              ),
            ),

            SizedBox(height: Responsive.responsiveSize(context, 10, 12, 14)),
            Divider(color: Colors.grey.withOpacity(0.25), thickness: 1),
            SizedBox(height: Responsive.responsiveSize(context, 10, 12, 14)),

            _shimmerBox(context, width: 100, height: 14), // instruction title
            SizedBox(height: Responsive.responsiveSize(context, 6, 8, 10)),
            _shimmerBox(context, width: double.infinity, height: 40), // instruction text

            SizedBox(height: Responsive.responsiveSize(context, 14, 16, 18)),

            // button
            _shimmerBox(
              context,
              width: double.infinity,
              height: Responsive.responsiveSize(context, 44, 50, 56),
              radius: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox(BuildContext context,
      {required double width, required double height, double radius = 6}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _circleShimmer(BuildContext context, {required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
