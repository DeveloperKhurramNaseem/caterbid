import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/app_logo.dart';
import 'package:caterbid/core/widgets/notification_screen.dart';
import 'package:caterbid/core/widgets/profile_avater.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLogo;
  final bool showActions;
  final Color? backgroundColor;
  final double? logoSize;

  const BaseAppBar({
    super.key,
    this.showLogo = true,
    this.showActions = true,
    this.backgroundColor,
    this.logoSize,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.appBackground,
      elevation: 0,
      surfaceTintColor: backgroundColor ?? AppColors.appBackground,
      automaticallyImplyLeading: false,
      centerTitle: false,

      // Left-side logo ß
      title: Row(
        children: [if (showLogo) AppLogo(insideAppBar: true, size: logoSize)],
      ),

      // Right-side actions
      actions: showActions ? const [NotificationIcon(), ProfileAvatar()] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
