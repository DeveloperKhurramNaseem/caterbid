import 'package:caterbid/core/config/app_constants.dart';
import 'package:flutter/material.dart';
import 'payment_detail_tile.dart';

class PaymentInfoCard extends StatelessWidget {
  const PaymentInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2FCFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PaymentDetailTile(
            title: "Dinner for Film Crew",
            subtitle: "Hollywood , CA",
            trailingText: "Sept 6, 2024 , 1:30 pm",
          ),
          Divider(color: Colors.grey),
          SizedBox(height: 4),
          Text(
            "Caterer Information",
            style: TextStyle(
              fontFamily: AppFonts.poppins,

              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          PaymentDetailTile(
            title: "Restaurant 1",
            subtitle: "Hollywood , CA",
            trailingText: "\$200",
            peopleCount: 200,
          ),
        ],
      ),
    );
  }
}
