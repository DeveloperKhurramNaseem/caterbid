import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class BusinessTextField extends StatelessWidget {
  final String label;
  final String? hintText;

  const BusinessTextField({super.key, required this.label, this.hintText});

  @override
  Widget build(BuildContext context) {
    final fontSize = Responsive.responsiveSize(context, 14, 16, 18);

    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.responsiveSize(context, 16, 20, 24)),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: fontSize, color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
