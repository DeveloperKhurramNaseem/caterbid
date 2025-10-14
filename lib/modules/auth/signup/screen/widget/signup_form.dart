import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:caterbid/modules/auth/signup/bloc/sign_up_bloc.dart';
import 'package:caterbid/modules/auth/signup/bloc/sign_up_state.dart';
import 'package:caterbid/modules/auth/signup/model/signup_request.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/agree_policy_row.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/role_dropdown.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/auth/verify_email_screen/main_screen/verify_email_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();

  bool _agree = false;
  bool _isDropdownFocused = false;
  String? _selectedRole;
  String? _fullPhoneNumber;

  // Text Controllers
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _company = TextEditingController();

  @override
  void initState() {
    super.initState();
    // clear any previous session
    _storage.deleteAll();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _name.dispose();
    _phone.dispose();
    _company.dispose();
    super.dispose();
  }

  String _roleForApi(String? role) {
    switch (role?.toLowerCase()) {
      case 'provide':
        return 'provider';
      case 'requestee':
        return 'requestee';
      default:
        return 'requestee';
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRole == null) {
      _showSnack('Please select a role');
      return;
    }
    if (!_agree) {
      _showSnack('Please agree to the policy');
      return;
    }

    final roleApi = _roleForApi(_selectedRole);

    final model = SignUpRequestModel(
      role: roleApi,
      email: _email.text.trim(),
      password: _password.text.trim(),
      name: _name.text.trim(),
      phoneNumber: _fullPhoneNumber ?? _phone.text.trim(),
      companyName: roleApi == 'provider' ? _company.text.trim() : null,
      lat: roleApi == 'provider' ? 37.7749 : null,
      lng: roleApi == 'provider' ? -122.4194 : null,
    );

    context.read<SignUpBloc>().add(SignUpButtonPressed(model));
  }

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          _showSnack('Sign up successful! Please verify your email.');
          context.push(
            VerifyEmailScreen.path,
            extra: {
              'email': _email.text.trim(),
              'role': _roleForApi(_selectedRole),
            },
          );
        } else if (state is SignUpFailure) {
          _showSnack(state.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is SignUpLoading;
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                RoleDropdown(
                  roles: const ['Provide', 'Requestee'],
                  selectedRole: _selectedRole,
                  isFocused: _isDropdownFocused,
                  onChanged: (v) => setState(() => _selectedRole = v),
                  onFocusChange: (f) => setState(() => _isDropdownFocused = f),
                ),
                SizedBox(height: h * 0.015),
                CustomTextField(
                  label: "Full Name",
                  controller: _name,
                  validator: (v) => v == null || v.isEmpty ? 'Enter your full name' : null,
                ),
                SizedBox(height: h * 0.02),
                CustomTextField(
                  label: "Email",
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter valid email';
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(v)) return 'Invalid email';
                    return null;
                  },
                ),
                SizedBox(height: h * 0.02),
                ContactNumberField(
                  controller: _phone,
                  onChanged: (value) => _fullPhoneNumber = value,
                ),
                SizedBox(height: h * 0.02),
                if (_selectedRole?.toLowerCase() == 'provide') ...[
                  CustomTextField(
                    label: "Company Name",
                    controller: _company,
                    validator: (v) => v == null || v.isEmpty ? 'Enter company name' : null,
                  ),
                  SizedBox(height: h * 0.02),
                ],
                CustomTextField(
                  label: "Password",
                  obscureText: true,
                  controller: _password,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter password';
                    if (v.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
                ),
                SizedBox(height: h * 0.02),
                CustomTextField(
                  label: "Confirm Password",
                  obscureText: true,
                  controller: _confirmPassword,
                  validator: (v) =>
                      v != _password.text ? 'Passwords do not match' : null,
                ),
                SizedBox(height: h * 0.015),
                AgreePolicyRow(
                  agree: _agree,
                  onChanged: (v) => setState(() => _agree = v ?? false),
                ),
                SizedBox(height: h * 0.03),
                isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(title: "Sign Up", isEnabled: _agree, onPressed: _submit),
              ],
            ),
          ),
        );
      },
    );
  }
}
