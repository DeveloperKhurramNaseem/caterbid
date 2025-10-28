import 'dart:io';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_business_type_dropdown.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_company_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_contact_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_description_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_location_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_profile_image_picker.dart';
import 'package:flutter/material.dart';

class ProviderProfileForm extends StatelessWidget {
  final TextEditingController companyController;
  final TextEditingController descriptionController;
  final TextEditingController phoneController;
  final TextEditingController locationController;
  final String? selectedBusinessType;
  final Function(String?) onBusinessTypeChanged;
  final Function(File?) onImageChanged;
  final String? initialImage;
  final String firstLetter;

  const ProviderProfileForm({
    super.key,
    required this.companyController,
    required this.descriptionController,
    required this.phoneController,
    required this.locationController,
    required this.selectedBusinessType,
    required this.onBusinessTypeChanged,
    required this.onImageChanged,
    this.initialImage,
    required this.firstLetter,
  });

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    final List<String> businessTypes = [
      'Restaurant',
      'Catering',
      'Bakery',
      'Food Truck',
      'Home Chef',
    ];

    return Column(
      children: [
        SizedBox(height: h * 0.03),
        ProviderProfileImagePicker(
          onImageChanged: onImageChanged,
          initialImage: initialImage,
          firstLetter: firstLetter,
        ),
        SizedBox(height: h * 0.04),
        ProviderCompanyField(controller: companyController),
        SizedBox(height: h * 0.02),
        ProviderBusinessTypeDropdown(
          selectedValue: selectedBusinessType,
          items: businessTypes,
          onChanged: onBusinessTypeChanged,
        ),
        SizedBox(height: h * 0.02),
        ProviderContactField(controller: phoneController),
        SizedBox(height: h * 0.02),
        ProviderLocationField(controller: locationController),
        SizedBox(height: h * 0.04),
        ProviderDescriptionField(controller: descriptionController),
        SizedBox(height: h * 0.04),
      ],
    );
  }
}
