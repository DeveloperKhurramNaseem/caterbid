import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'request_status_chip.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final String location;
  final String dateTime;
  final int amount;
  final int peopleCount;
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
    // Responsive measurements
    final double w = Responsive.width(context);
    final double h = Responsive.height(context);

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.02),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(
          Responsive.responsiveSize(context, 12, 16, 20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: h * 0.005),
          Text(
            location,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,

              fontSize: Responsive.responsiveSize(context, 12, 14, 16),
            ),
          ),
          SizedBox(height: h * 0.002),
          Text(
            dateTime,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: Responsive.responsiveSize(context, 12, 14, 16),
            ),
          ),
          SizedBox(height: h * 0.015),
          RequestStatusChip(status: status, isActive: isActive),
        ],
      ),
    );
  }

  /// Header with title (left) and amount + people (right)
  Widget _buildHeader(BuildContext context) {
    final double fontSize = Responsive.responsiveSize(context, 16, 17, 20);
    final double priceSize = Responsive.responsiveSize(context, 16, 16, 19);
    final double iconSize = Responsive.responsiveSize(context, 22, 16, 18);
    final double spacing = Responsive.responsiveSize(context, 4, 5, 7);
    
    final budget = amount;
    //For later used
    // final currency = request.currency.toUpperCase();
    final formatCurrency = NumberFormat.currency(symbol: '\$ ');
    String formatted = formatCurrency.format(budget); // $1,234.56

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
              color: AppColors.textDark,
              height: 1.2,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                formatted,
                style: TextStyle(
                  color: AppColors.icon,
                  fontSize: priceSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: spacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.group, size: iconSize, color: AppColors.icon),
                  SizedBox(width: spacing),
                  Flexible(
                    child: Text(
                      "$peopleCount people",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Responsive.responsiveSize(
                          context,
                          16,
                          25,
                          30,
                        ),
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
