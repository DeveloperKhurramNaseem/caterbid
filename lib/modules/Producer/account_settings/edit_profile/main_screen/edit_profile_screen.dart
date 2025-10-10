import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:caterbid/modules/Producer/account_settings/edit_profile/widgets/editing_appbar.dart';
import 'package:caterbid/modules/Producer/account_settings/edit_profile/widgets/name_fields.dart';
import 'package:caterbid/modules/Producer/account_settings/edit_profile/widgets/profile_image_picker.dart';
import 'package:caterbid/modules/Producer/account_settings/edit_profile/widgets/save_button.dart';
import 'package:flutter/material.dart';

import 'package:caterbid/core/utils/responsive.dart';


class EditProfileScreen extends StatelessWidget {
  static const path = '/editprofile';

  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const EditingAppbar(title: 'Edit Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Column(
            children: [
              SizedBox(height: h * 0.04),
              const ProfileImagePicker(),
              SizedBox(height: h * 0.05),
              const NameFields(),
              SizedBox(height: h * 0.02),
              const ContactNumberField(),
              SizedBox(height: h * 0.25),
              const SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
