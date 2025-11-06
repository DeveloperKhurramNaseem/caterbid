import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'request_status_chip.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final String location;
  final String dateTime;
  final String amount;
  final String peopleCount;
  final String status;

  const RequestCard({
    super.key,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.amount,
    required this.peopleCount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = status.toLowerCase() == "open";
    final double w = Responsive.width(context);
    final double h = Responsive.height(context);

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.018),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(
          Responsive.responsiveSize(context, 16, 20, 24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Title + Price Row ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppFonts.nunito,
                    fontWeight: FontWeight.w700,
                    fontSize: Responsive.responsiveSize(context, 16, 17, 20),
                    color: AppColors.textDark,
                    height: 1.2,
                  ),
                ),
              ),

              /// Amount
              Text(
                amount,
                style: TextStyle(
                  color: AppColors.icon,
                  fontSize: Responsive.responsiveSize(context, 16, 16, 19),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.006),

          /// --- Location & People Row ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Location
              Expanded(
                child: Text(
                  location,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Responsive.responsiveSize(context, 12, 13, 14),
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              /// People Count
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.group,
                    size: Responsive.responsiveSize(context, 15, 16, 17),
                    color: AppColors.icon,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    peopleCount,
                    style: TextStyle(
                      fontSize: Responsive.responsiveSize(context, 13, 14, 15),
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: h * 0.004),

          /// --- DateTime ---
          Text(
            dateTime,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: Responsive.responsiveSize(context, 12, 12.5, 13.5),
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: h * 0.012),

          /// --- Status Chip ---
          RequestStatusChip(status: status, isActive: isActive),
        ],
      ),
    );
  }
}
