import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const PhoneField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ContactNumberField(controller: controller, onChanged: onChanged);
  }
}
