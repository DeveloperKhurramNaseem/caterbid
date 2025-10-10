import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class NameFields extends StatelessWidget {
  const NameFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomTextField(label: "First Name"),
        SizedBox(height: 16),
        CustomTextField(label: "Last Name"),
      ],
    );
  }
}
