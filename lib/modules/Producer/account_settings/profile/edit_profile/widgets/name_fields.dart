import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class NameFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const NameFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "First Name",
          controller: firstNameController,
          validator: (v) =>
              v == null || v.isEmpty ? 'Enter your first name' : null,
          capitalizeFirstLetter: true,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: "Last Name",
          controller: lastNameController,
          validator: (v) =>
              v == null || v.isEmpty ? 'Enter your last name' : null,
          capitalizeFirstLetter: true,
        ),
      ],
    );
  }
}
