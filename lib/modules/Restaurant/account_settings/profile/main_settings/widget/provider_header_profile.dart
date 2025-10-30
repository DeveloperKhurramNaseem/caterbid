import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'provider_edit_profile_button.dart';

class ProviderHeaderProfile extends StatelessWidget {
  final String name;
  final String? companyName;
  final String? profileImageUrl;
  final String firstLetter;
  final bool isLoading;

  const ProviderHeaderProfile({
    super.key,
    required this.name,
    this.companyName,
    this.profileImageUrl,
    required this.firstLetter,
    this.isLoading = false,
  });

  const ProviderHeaderProfile.loading({super.key})
      : name = 'Loading...',
        companyName = null,
        profileImageUrl = null,
        firstLetter = '?',
        isLoading = true;

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = Responsive.responsiveSize(context, 45, 50, 55);
    final double borderWidth = Responsive.responsiveSize(context, 2, 6, 7);
    final double spacing = Responsive.responsiveSize(context, 20, 24, 28);

    final bool hasImage = profileImageUrl != null && profileImageUrl!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with border
          Container(
            padding: EdgeInsets.all(borderWidth),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.icon, width: borderWidth),
            ),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundImage: hasImage ? NetworkImage(profileImageUrl!) : null,
              child: !hasImage
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

          // Name, company, and edit button
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
                if (companyName != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      companyName!,
                      style: TextStyle(
                        fontSize: Responsive.responsiveSize(context, 14, 15, 16),
                        color: AppColors.textDark.withOpacity(0.7),
                      ),
                    ),
                  ),
                SizedBox(height: Responsive.responsiveSize(context, 8, 10, 12)),
                const ProviderEditProfileButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
