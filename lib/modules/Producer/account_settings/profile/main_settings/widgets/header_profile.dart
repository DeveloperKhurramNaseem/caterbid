import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'edit_profile_button.dart';

class HeaderProfile extends StatelessWidget {
  final String name;
  final String? profileImageUrl;
  final String firstLetter;
  final bool isLoading;

  const HeaderProfile({
    super.key,
    required this.name,
    this.profileImageUrl,
    required this.firstLetter,
    this.isLoading = false,
  });

  const HeaderProfile.loading({super.key})
      : name = 'Loading...',
        profileImageUrl = null,
        firstLetter = '?',
        isLoading = true;

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = Responsive.responsiveSize(context, 45, 50, 55);
    final double borderWidth = Responsive.responsiveSize(context, 2, 6, 7);
    final double spacing = Responsive.responsiveSize(context, 20, 24, 28);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
              backgroundColor: AppColors.c400,
              backgroundImage: profileImageUrl != null
                  ? NetworkImage(profileImageUrl!)
                  : const AssetImage('assets/images/dummy_profile.jpg') as ImageProvider,
              child: profileImageUrl == null
                  ? Text(
                      firstLetter.toUpperCase(),
                      style: TextStyle(
                        fontSize: avatarRadius * 0.9,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : null,
            ),
          ),

          SizedBox(width: spacing),

          // Name and edit button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: AppFonts.nunito,
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.responsiveSize(context, 19, 21, 23),
                    color: AppColors.textDark,
                  ),
                  overflow: TextOverflow.ellipsis,
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
