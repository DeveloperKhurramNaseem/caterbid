import 'package:flutter/material.dart';

class SortMenuButton extends StatelessWidget {
  final ValueChanged<String> onSelected;
  final String? currentSort;
  final double fontSize;
  final double iconSize;

  const SortMenuButton({
    super.key,
    required this.onSelected,
    this.currentSort,
    this.fontSize = 16,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      color: Colors.white,
      elevation: 6,
      offset: const Offset(0, 50),
      shadowColor: Colors.black.withOpacity(0.1),
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'latest',
          child: Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 18,
                color: currentSort == 'latest'
                    ? Colors.orange
                    : Colors.black54,
              ),
              const SizedBox(width: 10),
              Text(
                'Latest First',
                style: TextStyle(
                  color: currentSort == 'latest'
                      ? Colors.orange
                      : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(height: 1),
        PopupMenuItem(
          value: 'oldest',
          child: Row(
            children: [
              Icon(
                Icons.history_rounded,
                size: 18,
                color: currentSort == 'oldest'
                    ? Colors.orange
                    : Colors.black54,
              ),
              const SizedBox(width: 10),
              Text(
                'Oldest First',
                style: TextStyle(
                  color: currentSort == 'oldest'
                      ? Colors.orange
                      : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
      icon: Row(
        children: [
          Text(
            currentSort == null
                ? 'Sort'
                : currentSort == 'latest'
                    ? 'Latest First'
                    : 'Oldest First',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: iconSize,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
