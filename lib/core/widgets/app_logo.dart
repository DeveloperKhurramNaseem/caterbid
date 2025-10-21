import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';

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
      automaticallyImplyLeading: showBackButton,
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

/// Main AppLogo widget.
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

    // Dynamically calculate size based on context
    final double responsiveSize = (screenHeight * 0.20).clamp(90.0, 140.0);

    final double logoSize = insideAppBar
        ? (size ?? responsiveSize * 0.30) // Bigger in app bar
        : (size ?? responsiveSize);       // Even larger outside app bar

    return SizedBox(
      height: logoSize,
      child: Image.asset(
        'assets/icons/app_logo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
