import 'package:caterbid/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class CateringDetailsCard extends StatelessWidget {
  const CateringDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSmall = Responsive.responsiveSize(context, 12, 13, 14);
    final fontNormal = Responsive.responsiveSize(context, 14, 15, 16);
    final fontLarge = Responsive.responsiveSize(context, 16, 18, 20);

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
                "Dinner for Film Crew",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontLarge,
                  color: AppColors.c500,
                ),
              ),
              Text(
                "\$200",
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
            "Posted by: AB Producer",
            style: TextStyle(fontSize: fontSmall, color: Colors.grey[700]),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text("Sept 6, 2024", style: TextStyle(fontSize: fontSmall)),
              SizedBox(width: 12),
              const Icon(Icons.access_time, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text("1:30 pm", style: TextStyle(fontSize: fontSmall)),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.people_alt, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text("200 people", style: TextStyle(fontSize: fontSmall)),
              SizedBox(width: 12),
              const Icon(Icons.location_on, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text("Hollywood, CA", style: TextStyle(fontSize: fontSmall)),
            ],
          ),
          Divider(height: 20, color: Colors.grey.shade300),
          RichText(
            text: TextSpan(
              text: "Special Instruction\n",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: fontSmall,
              ),
              children: [
                TextSpan(
                  text: "Need gluten-free for 50 people",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w400,
                    fontSize: fontSmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
