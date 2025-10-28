import 'dart:io';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Restaurant/account_settings/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_editing_appbar.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_profile_form.dart';
import 'package:caterbid/modules/Restaurant/account_settings/edit_profile/widget/provider_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProviderEditProfileScreen extends StatefulWidget {
  static const path = '/provider_edit_profile';
  const ProviderEditProfileScreen({super.key});

  @override
  State<ProviderEditProfileScreen> createState() =>
      _ProviderEditProfileScreenState();
}

class _ProviderEditProfileScreenState extends State<ProviderEditProfileScreen> {
  File? pickedImage;
  String? selectedBusinessType;
  double lat = 0.0;
  double lng = 0.0;

  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<ProviderProfileBloc>().state;
    if (state is ProviderProfileLoaded) {
      final user = state.user;
      _companyController.text = user.companyName ?? '';
      _descriptionController.text = user.description ?? '';
      _phoneController.text = user.phoneNumber ?? '';
      // _locationController.text = user.formattedAddress ?? ''; // optional if you have address
      selectedBusinessType = user.businessType;
    }
  }

  void _onSave() {
    // Use default coordinates if not set
    double finalLat = lat == 0.0 ? 37.7749 : lat;
    double finalLng = lng == 0.0 ? -122.4194 : lng;

    context.read<ProviderProfileBloc>().add(
      ValidateAndSaveProviderEvent(
        name: _companyController.text.trim(),
        companyName: _companyController.text.trim(),
        businessType: selectedBusinessType ?? '',
        description: _descriptionController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        lat: finalLat,
        lng: finalLng,
        profilePicture: pickedImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const ProviderEditingAppbar(title: 'Edit Provider Profile'),
      body: SafeArea(
        child: BlocConsumer<ProviderProfileBloc, ProviderProfileState>(
          listener: (context, state) {
            if (state is ProviderProfileLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
              context.pop();
            } else if (state is ProviderProfileError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading =
                state is ProviderProfileUpdating ||
                state is ProviderProfileUpdatingKeepOld;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ProviderProfileForm(
                    companyController: _companyController,
                    descriptionController: _descriptionController,
                    phoneController: _phoneController,
                    locationController: _locationController,
                    selectedBusinessType: selectedBusinessType,
                    onBusinessTypeChanged: (val) =>
                        setState(() => selectedBusinessType = val),
                    onImageChanged: (file) =>
                        setState(() => pickedImage = file),
                    initialImage: (state is ProviderProfileLoaded)
                        ? state
                              .user
                              .profilePicture // 👈 Replace with your correct model field
                        : null,
                    firstLetter: (state is ProviderProfileLoaded)
                        ? (state.user.companyName?.isNotEmpty == true
                              ? state.user.companyName![0].toUpperCase()
                              : 'C')
                        : 'C',
                  ),
                  

                  ProviderSaveButton(
                    onPressed: _onSave,
                    isLoading: isLoading,
                    isEnabled: !isLoading,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
