import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class CateringDetailsCard extends StatelessWidget {
  final String title;
  final String postedBy;
  final String price;
  final String dateText;
  final String timeText;
  final String peopleText;
  final String locationText;
  final String? specialInstruction; // ✅ make nullable

  const CateringDetailsCard({
    super.key,
    required this.title,
    required this.postedBy,
    required this.price,
    required this.dateText,
    required this.timeText,
    required this.peopleText,
    required this.locationText,
    this.specialInstruction, // ✅ optional now
  });

  @override
  Widget build(BuildContext context) {
    final fontSmall = Responsive.responsiveSize(context, 12, 13, 14);
    final fontNormal = Responsive.responsiveSize(context, 14, 15, 16);
    final fontLarge = Responsive.responsiveSize(context, 16, 18, 20);

    final hasSpecialInstruction =
        specialInstruction != null && specialInstruction!.trim().isNotEmpty;

    return Container(
      padding: EdgeInsets.all(Responsive.responsiveSize(context, 10, 14, 16)),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Catering Request Details",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: fontNormal),
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontLarge,
                  color: AppColors.c500,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                  fontSize: fontLarge,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            "Posted by: $postedBy",
            style: TextStyle(fontSize: fontSmall, color: Colors.grey[700]),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text(dateText, style: TextStyle(fontSize: fontSmall)),
              SizedBox(width: 12),
              const Icon(Icons.access_time, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text(timeText, style: TextStyle(fontSize: fontSmall)),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.people_alt, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text(peopleText, style: TextStyle(fontSize: fontSmall)),
              SizedBox(width: 12),
            ],
          ),
          SizedBox(height: 6),

          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text(locationText, style: TextStyle(fontSize: fontSmall)),
            ],
          ),

          if (hasSpecialInstruction) ...[
            Divider(height: 20, color: Colors.grey.shade300),
            Text(
              "Special Instruction",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSmall,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              specialInstruction!,
              style: TextStyle(fontSize: fontSmall, color: Colors.grey[700]),
            ),
          ],
        ],
      ),
    );
  }
}
