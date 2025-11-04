import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';
import '../utils/responsive.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool capitalizeFirstLetter;
  final bool formatNumber;
  final bool readOnly; // <-- NEW

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.capitalizeFirstLetter = false,
    this.formatNumber = false,
    this.readOnly = false, // <-- NEW
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _numberFormatter = NumberFormat('#,###');

  String _formatNumber(String value) {
    String clean = value.replaceAll(',', '');
    if (clean.isEmpty) return '';

    List<String> parts = clean.split('.');
    String intPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    try {
      int number = int.parse(intPart);
      String formattedInt = _numberFormatter.format(number);
      return decimalPart.isNotEmpty ? '$formattedInt.$decimalPart' : formattedInt;
    } catch (_) {
      return value;
    }
  }

  String _capitalize(String value) {
    if (!widget.capitalizeFirstLetter || value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    double borderRadius = Responsive.responsiveSize(context, 12, 15, 18);
    double fontSize = Responsive.responsiveSize(context, 14, 16, 18);
    double verticalPadding = Responsive.responsiveSize(context, 12, 16, 18);
    double horizontalPadding = Responsive.responsiveSize(context, 12, 16, 20);

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly, // <-- NEW
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: widget.formatNumber
          ? [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))]
          : null,
      onChanged: (value) {
        if (widget.readOnly) return; // prevent changes if read-only

        String newValue = value;
        if (widget.formatNumber) newValue = _formatNumber(newValue);
        if (widget.capitalizeFirstLetter) newValue = _capitalize(newValue);

        if (widget.controller?.text != newValue) {
          widget.controller?.value = TextEditingValue(
            text: newValue,
            selection: TextSelection.collapsed(offset: newValue.length),
          );
        }
      },
      style: TextStyle(
        color: widget.readOnly ? Colors.grey[700] : AppColors.textDark,
        fontFamily: AppFonts.nunito,
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
      ),
      cursorColor: AppColors.textDark,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: AppColors.textDark,
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
        suffixIcon: widget.suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 1.5, color: AppColors.c500),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1.5, color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1.5, color: Colors.redAccent),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
      ),
    );
  }
}

extension TextControllerExtension on TextEditingController {
  String get rawValue => text.replaceAll(',', '');
}
