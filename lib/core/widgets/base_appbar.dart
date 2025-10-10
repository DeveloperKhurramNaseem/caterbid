import 'package:caterbid/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/notification_screen.dart';
import 'package:caterbid/core/widgets/profile_avater.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      title: Text(
        'CaterBid',
        style: TextStyle(
          fontSize: Responsive.responsiveSize(context, 22, 25, 28),
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: AppFonts.poppins,
        ),
      ),
      automaticallyImplyLeading: true,
      actions: const [NotificationIcon(), ProfileAvatar()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
