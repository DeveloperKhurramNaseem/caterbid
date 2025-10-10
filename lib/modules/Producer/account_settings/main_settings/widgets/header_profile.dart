import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'edit_profile_button.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = Responsive.responsiveSize(context, 45, 50, 55);
    final double borderWidth = Responsive.responsiveSize(context, 2, 6, 7);
    final double spacing = Responsive.responsiveSize(context, 20, 24, 28);

    return Padding(
      padding: EdgeInsetsGeometry.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with accent border
          Container(
            padding: EdgeInsets.all(borderWidth),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.icon, width: borderWidth),
            ),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundImage: const AssetImage('assets/images/dummy_profile.jpg'),
            ),
          ),
      
          SizedBox(width: spacing),
      
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aleesha Haider',
                  style: TextStyle(
                    fontFamily: AppFonts.nunito,
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.responsiveSize(context, 19, 21, 23),
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: Responsive.responsiveSize(context, 8, 10, 12)),
                const EditProfileButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
