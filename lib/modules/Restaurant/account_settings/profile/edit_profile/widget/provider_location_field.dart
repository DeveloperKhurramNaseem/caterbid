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
        // Wrap the TextField in a ConstrainedBox and AnimatedSize
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50, // Minimum height
              maxHeight: 200, // Maximum height for long addresses
            ),
            child: AbsorbPointer(
              absorbing: true, // disables focus/taps
              child: CustomTextField(
                label: "Business Location",
                controller: controller,
                readOnly: true,
                 maxLines: 5, 
                 minLines: 1,

                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter your business location' : null,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onChooseFromMap,
            icon: const Icon(Icons.location_pin, color: AppColors.icon, size: 16),
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
