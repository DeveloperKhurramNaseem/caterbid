import 'package:flutter/material.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:caterbid/core/config/app_colors.dart';

class LoaderOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoaderOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: isLoading,
      appIcon: Image.asset(
        'assets/icons/app_icon.png',
        width: 80,
        height: 80,
      ),
      circularProgressColor: AppColors.c500,
      overlayBackgroundColor: Colors.black.withOpacity(0.4),
      child: AbsorbPointer(
        absorbing: isLoading,
        child: child,
      ),
    );
  }
}
