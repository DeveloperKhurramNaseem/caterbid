import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    double iconSize = Responsive.responsiveSize(context, 30, 34, 36);
    double dotSize = Responsive.responsiveSize(context, 8, 10, 12);
    double padding = Responsive.responsiveSize(context, 4, 6, 8);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              size: iconSize,
            ),
            onPressed: () {
              // TODO: Navigate to notification screen
            },
          ),
          Positioned(
            right: Responsive.responsiveSize(context, 14, 18, 22),
            top: Responsive.responsiveSize(context, 14, 18, 22),
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
