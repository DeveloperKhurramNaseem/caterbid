import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ProviderBusinessTypeDropdown extends StatefulWidget {
  final String? selectedValue;
  final List<String> items;
  final Function(String?) onChanged;

  const ProviderBusinessTypeDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  State<ProviderBusinessTypeDropdown> createState() => _ProviderBusinessTypeDropdownState();
}

class _ProviderBusinessTypeDropdownState extends State<ProviderBusinessTypeDropdown> {
  String? _selectedValue;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
          value: _selectedValue,
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
                color: _isFocused ? AppColors.c500 : Colors.grey.withOpacity(0.3),
                width: 1.4,
              ),
            ),
          ),
          hint: const Text(
            'Select Business Type',
            style: TextStyle(
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.textDark,
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.c500),
          ),
          items: widget.items.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(
                type,
                style: const TextStyle(
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.textDark,
                ),
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() => _selectedValue = val);
            widget.onChanged(val);
          },
          validator: (val) => val == null || val.isEmpty ? 'Select a Business Type' : null,
        ),
      ),
    );
  }
}
