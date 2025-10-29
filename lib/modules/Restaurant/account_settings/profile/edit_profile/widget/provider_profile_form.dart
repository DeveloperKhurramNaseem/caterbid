import 'dart:io';
import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_business_type_dropdown.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_company_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_contact_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_description_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_location_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/model/provider_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/profile_image_picker.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/save_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderProfileForm extends StatefulWidget {
  final ProviderModel? user;

  const ProviderProfileForm({super.key, this.user});

  @override
  State<ProviderProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProviderProfileForm> {
  late final TextEditingController nameController;
  late final TextEditingController companyNameController;
  late final TextEditingController phoneController;
  // late final TextEditingController locationController;

  late final TextEditingController descriptionController;

  File? pickedImage;
  String? selectedBusinessType;
  bool isSaveEnabled = false;

  static const List<String> businessTypes = [
    'Catering',
    'Restaurant',
    'Food Truck',
    'Bakery',
    'Event Planner',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    companyNameController = TextEditingController();
    phoneController = TextEditingController();
    descriptionController = TextEditingController();

    if (widget.user != null) _fillControllers(widget.user!);

    nameController.addListener(_validateFields);
    companyNameController.addListener(_validateFields);
    phoneController.addListener(_validateFields);
  }

  void _fillControllers(ProviderModel user) {
    nameController.text = user.name ?? '';
    companyNameController.text = user.companyName ?? '';
    phoneController.text = user.phoneNumber ?? '';
    descriptionController.text = user.description ?? '';
    selectedBusinessType = user.businessType;
  }

  void _validateFields() {
    final areFieldsFilled =
        nameController.text.trim().isNotEmpty &&
        companyNameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        selectedBusinessType != null;

    setState(() => isSaveEnabled = areFieldsFilled);
  }

  void _onSave() {
    context.read<ProviderProfileBloc>().add(
          ValidateAndSaveProfileEvent(
            name: nameController.text.trim(),
            companyName: companyNameController.text.trim(),
            businessType: selectedBusinessType!,
            description: descriptionController.text.trim(),
            phoneNumber: phoneController.text.trim(),
            lat: widget.user?.latitude ?? 37.7749,
            lng: widget.user?.longitude ?? -122.4194,
            profilePicture: pickedImage,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    final user = widget.user;
    final image = user?.profilePicture;
    final letter = user?.firstLetter ?? '?';

    return Column(
      children: [
        SizedBox(height: h * 0.04),
        ProfileImagePicker(
          initialImage: image,
          firstLetter: letter,
          onImageChanged: (file) {
            setState(() => pickedImage = file);
            _validateFields();
          },
        ),
        SizedBox(height: h * 0.05),

                ProviderBusinessTypeDropdown(
          selectedValue: selectedBusinessType,
          items: businessTypes,
          onChanged: (val) {
            setState(() => selectedBusinessType = val);
            _validateFields();
          },
        ),

      
        const SizedBox(height: 16),

        ProviderCompanyField(controller: companyNameController),
        const SizedBox(height: 16),

        ProviderContactField(controller: phoneController),
        const SizedBox(height: 16),

        // ProviderLocationField(controller: locationController),

        ProviderDescriptionField(
          controller: descriptionController,
        ),
        SizedBox(height: h * 0.03),

        SaveButton(
          isEnabled: isSaveEnabled,
          isLoading: context.watch<ProviderProfileBloc>().state
              is ProviderProfileUpdating,
          onPressed: _onSave,
        ),
      ],
    );
  }
}