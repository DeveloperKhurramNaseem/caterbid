import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class DeleteAccountMessage extends StatelessWidget {
  const DeleteAccountMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleSize = Responsive.responsiveSize(context, 18, 22, 26);
    final subtitleSize = Responsive.responsiveSize(context, 14, 16, 18);

    return Column(
      children: [
        Text(
          'Are you sure you want to delete your account?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: Responsive.responsiveSize(context, 8, 10, 12)),
        Text(
          'Once you delete your account, it cannot be undone. All your data will be permanently erased from this app.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: subtitleSize,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
