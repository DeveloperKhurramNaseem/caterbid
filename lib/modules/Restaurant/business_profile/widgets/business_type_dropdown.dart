import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class BusinessTypeDropdown extends StatelessWidget {
  final String? selectedType;
  final List<String> businessTypes;
  final bool isFocused;
  final Function(String?) onChanged;
  final Function(bool) onFocusChange;

  const BusinessTypeDropdown({
    super.key,
    required this.selectedType,
    required this.businessTypes,
    required this.isFocused,
    required this.onChanged,
    required this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: onFocusChange,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<String>(
            value: selectedType,
            isExpanded: true,
            decoration: const InputDecoration(border: InputBorder.none),

            dropdownStyleData: DropdownStyleData(
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              elevation: 3,
              maxHeight: 200,
              offset: const Offset(0, 8),
            ),

            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.grey.withOpacity(0.05),
                border: Border.all(
                  color: isFocused
                      ? AppColors.c500
                      : Colors.grey.withOpacity(0.3),
                  width: 1.4,
                ),
              ),
            ),

            hint: Text(
              'Select Business Type',
              style: TextStyle(
                fontFamily: AppFonts.nunito,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.textDark.withOpacity(0.7),
              ),
            ),

            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.c500),
            ),

            items: businessTypes.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    type,
                    style: const TextStyle(
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              );
            }).toList(),

            onChanged: onChanged,
            validator: (val) => val == null ? 'Please select a business type' : null,
          ),
        ),
      ),
    );
  }
}
