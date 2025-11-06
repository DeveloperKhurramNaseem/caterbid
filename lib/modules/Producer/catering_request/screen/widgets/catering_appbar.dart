import 'package:caterbid/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class CateringAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CateringAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('New Catering Request'),
      titleTextStyle: TextStyle(
        fontSize: Responsive.responsiveSize(context, 22, 25, 28),
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.nunito,
      ),
      backgroundColor: AppColors.appBackground,
      surfaceTintColor: AppColors.appBackground,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: false,
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
