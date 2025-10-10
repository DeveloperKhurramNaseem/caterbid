import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';

class SpecialInstructionsField extends StatelessWidget {
  final String labelTextHolder;

  final TextEditingController controller;

  const SpecialInstructionsField({super.key, required this.controller, required this.labelTextHolder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 4,
      maxLines: null,
      style: const TextStyle(
        color: AppColors.textDark,
        fontFamily: AppFonts.nunito,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: AppColors.textDark,
      decoration: InputDecoration(
        labelText: labelTextHolder,
        labelStyle: const TextStyle(
          color: AppColors.textDark,
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1.5, color: AppColors.c500),
        ),
        alignLabelWithHint: true,
      ),
    );
  }
}
