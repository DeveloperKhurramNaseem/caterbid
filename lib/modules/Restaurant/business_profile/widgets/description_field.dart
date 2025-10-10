import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = Responsive.responsiveSize(context, 14, 16, 18);

    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Add Description',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      style: TextStyle(fontSize: fontSize),
    );
  }
}
