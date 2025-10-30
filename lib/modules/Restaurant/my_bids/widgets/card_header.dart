import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

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
    final double fontSize = Responsive.responsiveSize(context, 16, 17, 20);
    final double priceSize = Responsive.responsiveSize(context, 16, 16, 19);
    final double iconSize = Responsive.responsiveSize(context, 14, 16, 18);
    final double spacing = Responsive.responsiveSize(context, 3, 4, 6);

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
