import 'package:flutter/material.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        color: Color(0xFF0097A7),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
