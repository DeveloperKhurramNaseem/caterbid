import 'package:caterbid/modules/Restaurant/home/screen/widegts/icon_info_row.dart';
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
  final String? specialInstruction; 

  const CateringDetailsCard({
    super.key,
    required this.title,
    required this.postedBy,
    required this.price,
    required this.dateText,
    required this.timeText,
    required this.peopleText,
    required this.locationText,
    this.specialInstruction,
  });

  @override
  Widget build(BuildContext context) {
    final fontSmall = Responsive.responsiveSize(context, 12, 13, 14);
    final fontNormal = Responsive.responsiveSize(context, 14, 15, 16);
    final fontLarge = Responsive.responsiveSize(context, 16, 18, 20);
    final pad = Responsive.responsiveSize(context, 10, 14, 16);

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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Header ---
          Text(
            "Catering Request Details",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: fontNormal,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),

          /// --- Title + Price ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: fontLarge,
                    color: AppColors.c500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8),
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

          /// --- Info Rows (using reusable IconInfoRow) ---
          Wrap(
            spacing: Responsive.responsiveSize(context, 12, 14, 16),
            runSpacing: Responsive.responsiveSize(context, 6, 8, 10),
            children: [
              IconInfoRow(
                  icon: Icons.calendar_today_outlined, text: dateText),
              IconInfoRow(icon: Icons.access_time, text: timeText),
              IconInfoRow(icon: Icons.people_alt_outlined, text: peopleText),
              IconInfoRow(icon: Icons.location_on_outlined, text: locationText),
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
