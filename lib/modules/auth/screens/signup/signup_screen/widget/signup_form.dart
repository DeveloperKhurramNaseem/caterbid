import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:caterbid/modules/auth/screens/signup/signup_screen/widget/agree_policy_row.dart';
import 'package:caterbid/modules/auth/screens/signup/signup_screen/widget/role_dropdown.dart';
import 'package:caterbid/core/utils/responsive.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool _agree = false;
  bool _isDropdownFocused = false;
  String? _selectedRole;
  final roles = ['Customer', 'Vendor', 'Admin'];

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          RoleDropdown(
            selectedRole: _selectedRole,
            roles: roles,
            isFocused: _isDropdownFocused,
            onChanged: (val) => setState(() => _selectedRole = val),
            onFocusChange: (focus) =>
                setState(() => _isDropdownFocused = focus),
          ),
          SizedBox(height: h * 0.01),

          const CustomTextField(label: "Email"),
          SizedBox(height: h * 0.02),

          const CustomTextField(label: "Password", obscureText: true),
          SizedBox(height: h * 0.02),

          const CustomTextField(label: "Confirm Password", obscureText: true),
          SizedBox(height: h * 0.01),

          AgreePolicyRow(
            agree: _agree,
            onChanged: (v) => setState(() => _agree = v ?? false),
          ),
          SizedBox(height: h * 0.03),

          CustomButton(
            title: "Sign Up",
            isEnabled: _agree,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // TODO: Add BLoC or API integration
              }
            },
          ),
        ],
      ),
    );
  }
}
