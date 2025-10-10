import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class EditingAppbar extends StatelessWidget implements PreferredSizeWidget {
    final String title;

  const EditingAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(
        fontSize: Responsive.responsiveSize(context, 22, 25, 28),
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.nunito,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: false,
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}