import 'package:caterbid/modules/auth/signup/screen/widget/role_dropdown.dart';
import 'package:flutter/material.dart';

class RoleDropdownField extends StatefulWidget {
  final String? selectedRole;
  final Function(String?)? onChanged;

  const RoleDropdownField({super.key, this.selectedRole, this.onChanged});

  @override
  State<RoleDropdownField> createState() => _RoleDropdownFieldState();
}

class _RoleDropdownFieldState extends State<RoleDropdownField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return RoleDropdown(
      roles: const ['Provider', 'Requestee'],
      selectedRole: widget.selectedRole,
      isFocused: _isFocused,
      onChanged: (v) {
        if (widget.onChanged != null) widget.onChanged!(v);
      },
      onFocusChange: (f) => setState(() => _isFocused = f),
    );
  }
}
