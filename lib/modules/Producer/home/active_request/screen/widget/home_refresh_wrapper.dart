import 'package:caterbid/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class HomeRefreshWrapper extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const HomeRefreshWrapper({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.c500,
      child: child,
    );
  }
}
