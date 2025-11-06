import 'package:caterbid/modules/auth/signup/screen/widget/email_field.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/full_name_field.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/password_field.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/phone_field.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/role_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:caterbid/modules/auth/signup/model/signup_request.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/agree_policy_row.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class SignUpForm extends StatefulWidget {
  final Function(SignUpRequestModel) onSubmit;

  const SignUpForm({super.key, required this.onSubmit});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  bool _agree = false;
  String? _selectedRole;
  String? _fullPhoneNumber;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  // final _company = TextEditingController(); //  Removed company name field

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _name.dispose();
    _phone.dispose();
    // _company.dispose(); //  Removed company name field
    _scrollController.dispose();
    super.dispose();
  }

  String _roleForApi(String? role) {
    switch (role?.toLowerCase()) {
      case 'provider':
        return 'provider';
      case 'requestee':
        return 'requestee';
      default:
        return 'requestee';
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      _scrollToTop();
      return;
    }

    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role')),
      );
      return;
    }

    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the policy')),
      );
      return;
    }

    final model = SignUpRequestModel(
      role: _roleForApi(_selectedRole),
      email: _email.text.trim(),
      password: _password.text.trim(),
      name: _name.text.trim(),
      phoneNumber: _fullPhoneNumber ?? _phone.text.trim(),
      // companyName: _selectedRole?.toLowerCase() == 'provider'
      //     ? _company.text.trim()
      //     : null, //  Company name removed for provider
    );

    widget.onSubmit(model);
  }

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    final isSmall = h < 700;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            RoleDropdownField(
              selectedRole: _selectedRole,
              onChanged: (v) => setState(() => _selectedRole = v),
            ),
            SizedBox(height: isSmall ? 10 : h * 0.015),
            FullNameField(controller: _name),
            SizedBox(height: isSmall ? 12 : h * 0.02),
            EmailField(controller: _email),
            SizedBox(height: isSmall ? 12 : h * 0.02),
            PhoneField(controller: _phone, onChanged: (v) => _fullPhoneNumber = v),

            //  Removed company name field section
            // if (_selectedRole?.toLowerCase() == 'provider') ...[
            //   SizedBox(height: isSmall ? 12 : h * 0.02),
            //   CompanyNameField(controller: _company),
            // ],

            SizedBox(height: isSmall ? 12 : h * 0.02),
            PasswordField(
              controller: _password,
              label: 'Password',
              validator: (v) {
                if (v == null || v.isEmpty) return 'Enter password';
                if (v.length < 6) return 'Minimum 6 characters';
                return null;
              },
            ),
            SizedBox(height: isSmall ? 12 : h * 0.02),
            PasswordField(
              controller: _confirmPassword,
              label: 'Confirm Password',
              validator: (v) => v != _password.text ? 'Passwords do not match' : null,
            ),
            SizedBox(height: isSmall ? 8 : h * 0.015),
            AgreePolicyRow(
              agree: _agree,
              onChanged: (v) => setState(() => _agree = v ?? false),
            ),
            SizedBox(height: isSmall ? 16 : h * 0.03),
            CustomButton(
              title: "Sign Up",
              isEnabled: _agree,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
