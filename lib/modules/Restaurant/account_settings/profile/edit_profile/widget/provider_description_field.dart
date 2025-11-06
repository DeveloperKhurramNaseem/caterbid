import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/special_instructions_field.dart';
import 'package:flutter/material.dart';

class ProviderDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  const ProviderDescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SpecialInstructionsField(
      labelTextHolder: 'Description',
      controller: controller, 
    );
  }
}
