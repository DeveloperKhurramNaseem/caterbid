import 'package:caterbid/modules/Restaurant/my_bids/widgets/info_text.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'mark_as_fullfilled.dart';
import 'status_tag.dart';
import 'card_header.dart';

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
    final double w = Responsive.width(context);

    final bool hasMyBid = myBidAmount != null && myBidAmount!.isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: h * 0.015, bottom: h * 0.02),
          padding: EdgeInsets.all(w * 0.04),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Header ---
              CardHeader(
                title: title,
                amount: amount,
                peopleCount: peopleCount,
                postedBy: postedBy,
              ),
              // SizedBox(height: h * 0.001),

              /// --- Meta Info ---
              InfoText(value: postedBy),
              SizedBox(height: h * 0.005),
              InfoText(value: location),
              SizedBox(height: h * 0.005),
              InfoText(value: dateTime),

              SizedBox(height: h * 0.005),

              const Divider(height: 18, color: Color(0xFFE0E0E0)),

              /// --- My Bid Details Section ---
              if (hasMyBid) ...[
                Text(
                  "My Bid Details",
                  style: TextStyle(
                    fontSize: Responsive.responsiveSize(context, 14, 16, 18),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: h * 0.008),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Description
                    Expanded(
                      flex: 3,
                      child: Text(
                        (myBidDescription?.isNotEmpty ?? false)
                            ? myBidDescription!
                            : "No description provided.",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: Responsive.responsiveSize(
                            context,
                            12,
                            14,
                            15,
                          ),
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(width: w * 0.03),

                    /// Bid Amount
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Text(
                          //   "Bid Amount",
                          //   style: TextStyle(
                          //     color: Colors.grey.shade600,
                          //     fontSize: Responsive.responsiveSize(
                          //       context,
                          //       11,
                          //       13,
                          //       14,
                          //     ),
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // SizedBox(height: h * 0.002),
                          Text(
                            myBidAmount!,
                            style: TextStyle(
                              fontSize: Responsive.responsiveSize(
                                context,
                                13,
                                15,
                                17,
                              ),
                              fontWeight: FontWeight.bold,
                              color: AppColors.icon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],

              if (hasMyBid) SizedBox(height: h * 0.015),

              /// --- Fulfilled Button (for Active) ---
              if (status == 'Active')
                const MarkAsFullfilled(title: 'Mark as Fulfilled'),
            ],
          ),
        ),

        /// --- Status Tag ---
        Positioned(top: 1, left: 15, child: StatusTag(status: status)),
      ],
    );
  }
}
