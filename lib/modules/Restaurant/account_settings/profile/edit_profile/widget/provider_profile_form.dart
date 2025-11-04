import 'dart:io';
import 'package:caterbid/core/widgets/map/reusable_map_picker.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/profile_image_picker.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_business_type_dropdown.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_company_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_contact_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_description_field.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/model/provider_profile_model.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_location_field.dart';
import 'package:caterbid/core/utils/helpers/location_formatter.dart';
import 'package:go_router/go_router.dart';

class ProviderProfileForm extends StatefulWidget {
  final ProviderModel? user;

  const ProviderProfileForm({super.key, this.user});

  @override
  State<ProviderProfileForm> createState() => _ProviderProfileFormState();
}

class _ProviderProfileFormState extends State<ProviderProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController companyNameController;
  late final TextEditingController phoneController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;

  File? pickedImage;
  String? selectedBusinessType;
  double? selectedLat;
  double? selectedLng;
  bool isSaveEnabled = false;

  static const businessTypes = [
    'Restaurant',
    'Catering Service',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    companyNameController = TextEditingController();
    phoneController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();

    if (widget.user != null) _fillControllers(widget.user!);


  // Add listeners that affect the Save button
    nameController.addListener(_validateFields);
    companyNameController.addListener(_validateFields);
    phoneController.addListener(_validateFields);
    descriptionController.addListener(_validateFields);

  }

  void _fillControllers(ProviderModel user) {
    nameController.text = user.name ?? '';
    companyNameController.text = user.companyName ?? '';
    phoneController.text = user.phoneNumber ?? '';
    descriptionController.text = user.description ?? '';
    selectedBusinessType = user.businessType;

    selectedLat = user.latitude;
    selectedLng = user.longitude;

    locationController.text = 'Business Location';
    _convertLatLngToAddress();
  }

void _validateFields() {
  final user = widget.user;

  final filled = nameController.text.trim().isNotEmpty &&
      companyNameController.text.trim().isNotEmpty &&
      phoneController.text.trim().isNotEmpty &&
      selectedBusinessType != null;

      

  // Check if any value changed
  final hasChanges = filled &&
      (nameController.text.trim() != (user?.name ?? '') ||
          companyNameController.text.trim() != (user?.companyName ?? '') ||
          phoneController.text.trim() != (user?.phoneNumber ?? '') ||
          (descriptionController.text.trim() != (user?.description ?? '')) ||
          selectedBusinessType != user?.businessType ||
          pickedImage != null ||
          selectedLat != user?.latitude ||
          selectedLng != user?.longitude);

  setState(() => isSaveEnabled = hasChanges);
}

  Future<void> _convertLatLngToAddress() async {
    if (selectedLat == null || selectedLng == null) return;
    try {
      final address = await LocationFormatter.getFormattedAddress(
        latitude: selectedLat!,
        longitude: selectedLng!,
      );
      if (mounted) locationController.text = address ?? 'Unknown location';
    } catch (_) {
      if (mounted) locationController.text = 'Failed to fetch address';
    }
  }
  

  Future<void> _pickLocation() async {
    final result = await context.push<Map<String, dynamic>>(
      ReusableMapPicker.path,
    );

    if (!mounted || result == null) return;

    setState(() {
      selectedLat = result['lat'];
      selectedLng = result['lng'];
      locationController.text = result['address'] ?? 'Selected location';
    });

  _validateFields();

  }

  void _onSave() {
    if (!isSaveEnabled) return;

    context.read<ProviderProfileBloc>().add(
          ValidateAndSaveProfileEvent(
            name: nameController.text.trim(),
            companyName: companyNameController.text.trim(),
            businessType: selectedBusinessType!,
            description: descriptionController.text.trim(),
            phoneNumber: phoneController.text.trim(),
            lat: selectedLat ?? widget.user?.latitude ?? 37.7749,
            lng: selectedLng ?? widget.user?.longitude ?? -122.4194,
            profilePicture: pickedImage,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final user = widget.user;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: h * 0.03),

          ProfileImagePicker(
            initialImage: user?.profilePicture,
            firstLetter: user?.firstLetter ?? '?',
            onImageChanged: (file) {
              setState(() => pickedImage = file);
              _validateFields();
            },
          ),

          SizedBox(height: h * 0.03),
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

          ProviderLocationField(
            controller: locationController,
            onChooseFromMap: _pickLocation,
          ),
          const SizedBox(height: 16),

          ProviderDescriptionField(controller: descriptionController),
          SizedBox(height: h * 0.03),

          SaveButton(
            isEnabled: isSaveEnabled,
            isLoading: context.select<ProviderProfileBloc, bool>(
              (bloc) =>
                  bloc.state is ProviderProfileUpdating ||
                  bloc.state is ProviderProfileUpdatingKeepOld,
            ),
            onPressed: _onSave,
          ),
        ],
      ),
    );
  }
}
