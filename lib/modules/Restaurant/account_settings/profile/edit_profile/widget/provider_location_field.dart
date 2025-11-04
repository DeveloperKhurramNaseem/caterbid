import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/config/app_colors.dart';

class ProviderLocationField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChooseFromMap;

  const ProviderLocationField({
    super.key,
    required this.controller,
    required this.onChooseFromMap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AbsorbPointer(
          absorbing: true, // disables focus/taps
          child: CustomTextField(
            label: "Business Location",
            controller: controller,
            readOnly: true,
            validator: (v) =>
                v == null || v.isEmpty ? 'Enter your business location' : null,
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onChooseFromMap,
            label: const Text(
              "Choose from map",
              style: TextStyle(color: AppColors.icon, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
