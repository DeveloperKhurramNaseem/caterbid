import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:flutter/material.dart';

class AgreePolicyRow extends StatelessWidget {
  final bool agree;
  final ValueChanged<bool?> onChanged;

  const AgreePolicyRow({
    super.key,
    required this.agree,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.translate(
          offset: const Offset(-4, 0),
          child: Checkbox(
            value: agree,
            onChanged: onChanged,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: AppColors.c500,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: "Agree to ",
              style: const TextStyle(
                fontFamily: AppFonts.nunito,
                color: AppColors.textDark,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              children: [
                TextSpan(
                  text: "Privacy Policy ",
                  style: TextStyle(
                    fontFamily: AppFonts.nunito,
                    color: AppColors.c500,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: "and "),
                TextSpan(
                  text: "Terms & Conditions",
                  style: TextStyle(
                    fontFamily: AppFonts.nunito,
                    color: AppColors.c500,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
