import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class DeleteAccountIcon extends StatelessWidget {
  const DeleteAccountIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.warning_rounded,
      color: Colors.red,
      size: Responsive.responsiveSize(context, 80, 100, 120),
    );
  }
}
