import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class CardHeader extends StatelessWidget {
  final String title;
  final String amount;
  final int peopleCount;
  final String postedBy;

  const CardHeader({
    super.key,
    required this.title,
    required this.amount,
    required this.peopleCount,
    required this.postedBy,
  });

  @override
  Widget build(BuildContext context) {
    final double titleSize = Responsive.responsiveSize(context, 16, 17, 20);
    final double priceSize = Responsive.responsiveSize(context, 16, 16, 19);
    final double iconSize = Responsive.responsiveSize(context, 14, 16, 18);
    final double spacing = Responsive.responsiveSize(context, 3, 4, 6);
    final double postedBySize = Responsive.responsiveSize(context, 12, 13, 14);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- LEFT: Title + Posted By ----
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w700,
                  fontSize: titleSize,
                  color: AppColors.textDark,
                  height: 1.2,
                ),
              ),
              SizedBox(height: spacing * 0.8), // tiny gap
              Text(
                postedBy,
                style: TextStyle(
                  fontSize: postedBySize,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // ---- RIGHT: Amount + People ----
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
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
                          12,
                          13,
                          15,
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