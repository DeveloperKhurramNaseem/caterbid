import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class VersionLabel extends StatelessWidget {
  const VersionLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Version 1.0.1',
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: Responsive.responsiveSize(context, 10, 12, 13),
        fontFamily: 'Nunito',
      ),
    );
  }
}
