import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart'; // adjust path if needed

/// A reusable AppBar with your logo centered.
class AppLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final Color? backgroundColor;
  final double? logoSize;

  const AppLogoAppBar({
    super.key,
    this.showBackButton = true,
    this.backgroundColor,
    this.logoSize,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: backgroundColor ?? AppColors.appBackground,
      surfaceTintColor: backgroundColor ?? AppColors.appBackground,
      elevation: 0,
      title: AppLogo(
        insideAppBar: true,
        size: logoSize,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// The main AppLogo widget for sizing and displaying the logo.
class AppLogo extends StatelessWidget {
  final double? size;
  final bool insideAppBar;

  const AppLogo({
    super.key,
    this.size,
    this.insideAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final double logoSize = insideAppBar
        ? (size ?? kToolbarHeight * 0.7)
        : (size ?? screenHeight * 0.12);

    return SizedBox(
      height: logoSize,
      child: Image.asset(
        'assets/icons/app_logo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
