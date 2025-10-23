import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';

class SpecialInstructionsField extends StatelessWidget {
  final String labelTextHolder;
  final TextEditingController controller;

  final IconData? iconData;
  final String? iconAsset;
  final VoidCallback? onIconTap;

  const SpecialInstructionsField({
    super.key,
    required this.controller,
    required this.labelTextHolder,
    this.iconData,
    this.iconAsset,
    this.onIconTap,
  });

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

        ///  Conditional icon on the right
        suffixIcon: (iconData != null || iconAsset != null)
            ? InkWell(
                onTap: onIconTap,
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: iconData != null
                      ? Icon(iconData, color: AppColors.icon, size: 24)
                      : Image.asset(
                          iconAsset!,
                          width: 24,
                          height: 24,
                          color: AppColors.icon,
                        ),
                ),
              )
            : null,
      ),
    );
  }
}
