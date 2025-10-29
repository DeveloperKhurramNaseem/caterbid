import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:flutter/material.dart';

class ProviderContactField extends StatelessWidget {
  final TextEditingController controller;

  const ProviderContactField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ContactNumberField(
      controller: controller,
    );
  }
}
