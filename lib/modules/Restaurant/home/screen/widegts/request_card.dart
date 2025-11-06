import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'icon_info_row.dart';

class BidRequestCard extends StatelessWidget {
  final String title;
  final String postedBy;
  final String price;
  final String dateText;
  final String timeText;
  final String peopleText;
  final String locationText;
  final String? specialInstruction; // ✅ made nullable
  final VoidCallback onPlaceBid;

  const BidRequestCard({
    super.key,
    required this.title,
    required this.postedBy,
    required this.price,
    required this.dateText,
    required this.timeText,
    required this.peopleText,
    required this.locationText,
    this.specialInstruction, // ✅ optional now
    required this.onPlaceBid,
  });

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.responsiveSize(context, 12, 16, 20);
    final titleSize = Responsive.responsiveSize(context, 18, 20, 22);
    final labelSize = Responsive.responsiveSize(context, 12, 13, 14);

    final hasSpecialInstruction =
        specialInstruction != null && specialInstruction!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---- Header: Title + Price ----
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: AppColors.icon,
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

          /// ---- Icons Info ----
          Wrap(
            spacing: Responsive.responsiveSize(context, 10, 12, 14),
            runSpacing: Responsive.responsiveSize(context, 6, 8, 10),
            children: [
              IconInfoRow(icon: Icons.calendar_today, text: dateText),
              IconInfoRow(icon: Icons.access_time, text: timeText),
              IconInfoRow(icon: Icons.people_alt_outlined, text: peopleText),
              IconInfoRow(icon: Icons.location_on_outlined, text: locationText),
            ],
          ),

          if (hasSpecialInstruction) ...[
            SizedBox(height: Responsive.responsiveSize(context, 10, 12, 14)),
            Divider(color: Colors.grey.withOpacity(0.25), thickness: 1),
            SizedBox(height: Responsive.responsiveSize(context, 10, 12, 14)),

            /// ---- Special Instructions ----
            Text(
              'Special Instruction',
              style: TextStyle(
                fontSize: labelSize,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: Responsive.responsiveSize(context, 6, 8, 10)),
            Text(
              specialInstruction!,
              style: TextStyle(fontSize: labelSize, color: Colors.black87),
            ),
          ],

          SizedBox(height: Responsive.responsiveSize(context, 14, 16, 18)),

          /// ---- Button ----
          SizedBox(
            width: double.infinity,
            height: Responsive.responsiveSize(context, 44, 50, 56),
            child: ElevatedButton(
              onPressed: onPlaceBid,
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
}
