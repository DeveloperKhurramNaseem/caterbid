import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'mark_as_fullfilled.dart';
import 'status_tag.dart';
import 'card_header.dart';
import 'my_bid_section.dart';

class BidsCard extends StatelessWidget {
  final String title;
  final String postedBy;
  final String location;
  final String dateTime;
  final String amount;
  final int peopleCount;
  final String status;
  final String? myBidAmount;
  final String? myBidDescription;

  const BidsCard({
    super.key,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.amount,
    required this.peopleCount,
    required this.status,
    this.myBidAmount,
    this.myBidDescription,
    required this.postedBy,
  });

  @override
  Widget build(BuildContext context) {
    final double h = Responsive.height(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: h * 0.015, bottom: h * 0.02),
          padding: EdgeInsets.all(Responsive.width(context) * 0.04),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(
              Responsive.responsiveSize(context, 12, 16, 20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: title,
                amount: amount,
                peopleCount: peopleCount,
                postedBy: postedBy,
              ),
              // SizedBox(height: h * 0.005),

              Text(
              postedBy,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.responsiveSize(context, 12, 14, 16),
                ),
              ),

              SizedBox(height: h * 0.005),

              // Location
              Text(
                location,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.responsiveSize(context, 12, 14, 16),
                ),
              ),
              SizedBox(height: h * 0.002),

              // Date & Time
              Text(
                dateTime,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.responsiveSize(context, 12, 14, 16),
                ),
              ),
              SizedBox(height: h * 0.015),

              // Divider
              const Divider(height: 20, color: Color(0xFFE0E0E0)),

              // My Bid Section (only for Active)
              if (status == 'Active' && myBidAmount != null)
                MyBidSection(
                  amount: myBidAmount!,
                  description: myBidDescription,
                ),

              // Mark as Fulfilled
              if (status == 'Active')
                const MarkAsFullfilled(title: 'Mark as Fulfilled')
              else
                const SizedBox.shrink(),
            ],
          ),
        ),

        // Status Tag
        Positioned(top: 5, left: 15, child: StatusTag(status: status)),
      ],
    );
  }
}
