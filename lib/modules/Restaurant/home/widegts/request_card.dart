import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Restaurant/place_bid/screen/place_bid_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class BidRequestCard extends StatelessWidget {
  final String title;
  final String postedBy;
  final String price;
  final String dateText;
  final String timeText;
  final String peopleText;
  final String locationText;
  final String specialInstructionTitle;
  final String specialInstruction;

  const BidRequestCard({
    super.key,
    required this.title,
    required this.postedBy,
    required this.price,
    required this.dateText,
    required this.timeText,
    required this.peopleText,
    required this.locationText,
    required this.specialInstructionTitle,
    required this.specialInstruction,
  });

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.responsiveSize(context, 12, 16, 20);
    final titleSize = Responsive.responsiveSize(context, 18, 20, 22);
    final labelSize = Responsive.responsiveSize(context, 12, 13, 14);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top row: title and price
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0D4B4B),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFDE8A15),
                ),
              ),
            ],
          ),

          SizedBox(height: Responsive.responsiveSize(context, 6, 8, 10)),

          Text(
            'Posted by: $postedBy',
            style: TextStyle(fontSize: labelSize, color: Colors.black54),
          ),

          SizedBox(height: Responsive.responsiveSize(context, 8, 10, 12)),

          // icons info
          Wrap(
            runSpacing: 6,
            spacing: 12,
            children: [
              _iconInfo(context, Icons.calendar_today, dateText, labelSize),
              _iconInfo(context, Icons.access_time, timeText, labelSize),
              _iconInfo(
                context,
                Icons.people_alt_outlined,
                peopleText,
                labelSize,
              ),
              _iconInfo(
                context,
                Icons.location_on_outlined,
                locationText,
                labelSize,
              ),
            ],
          ),

          SizedBox(height: Responsive.responsiveSize(context, 10, 12, 14)),
          Divider(color: Colors.grey.withOpacity(0.25), thickness: 1),
          SizedBox(height: Responsive.responsiveSize(context, 10, 12, 14)),

          Text(
            specialInstructionTitle,
            style: TextStyle(
              fontSize: labelSize,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: Responsive.responsiveSize(context, 6, 8, 10)),
          Text(
            specialInstruction,
            style: TextStyle(fontSize: labelSize, color: Colors.black87),
          ),

          SizedBox(height: Responsive.responsiveSize(context, 14, 16, 18)),

          // button
          SizedBox(
            width: double.infinity,
            height: Responsive.responsiveSize(context, 44, 50, 56),
            child: ElevatedButton(
              onPressed: () {
                context.push(PlaceBidScreen.path);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.c500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Place Bid',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.responsiveSize(context, 16, 18, 20),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconInfo(
    BuildContext context,
    IconData icon,
    String label,
    double size,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: Responsive.responsiveSize(context, 16, 18, 20),
          color: const Color(0xFFDE8A15),
        ),
        SizedBox(width: Responsive.responsiveSize(context, 6, 8, 10)),
        Text(
          label,
          style: TextStyle(fontSize: size, color: Colors.black54),
        ),
      ],
    );
  }
}
