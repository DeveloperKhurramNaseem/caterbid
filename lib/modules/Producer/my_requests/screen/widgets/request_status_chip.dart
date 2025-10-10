import 'package:flutter/material.dart';

class RequestStatusChip extends StatelessWidget {
  final String status;
  final bool isActive;

  const RequestStatusChip({
    super.key,
    required this.status,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isActive ? Colors.orange : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isActive ? Colors.orange : Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
