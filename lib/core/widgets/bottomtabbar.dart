import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class NavItem {
  final String label;
  final IconData icon;
  final String route;

  NavItem({required this.label, required this.icon, required this.route});
}

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<NavItem> items;

  const BottomNavBar({
    super.key,
    required this.navigationShell,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = Responsive.responsiveSize(context, 26, 30, 34);
    double fontSize = Responsive.responsiveSize(context, 12, 14, 16);

    return Scaffold(
      body: navigationShell, // GoRouter provides the active branch content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.c500,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
        ),
        items: items
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon, size: iconSize),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
