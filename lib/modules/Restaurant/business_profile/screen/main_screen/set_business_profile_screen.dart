import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/core/widgets/special_instructions_field.dart';
import 'package:caterbid/core/widgets/loader_overlay.dart';

import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/business_profile/bloc/business_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/business_profile/model/business_profile_request_model.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/location_field.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/next_button.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/upload_picture_box.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/business_type_dropdown.dart';
import 'package:caterbid/modules/Restaurant/home/screen/main_screen/bids_home.dart';

class SetBusinessProfileScreen extends StatefulWidget {
  static const String path = '/setbusinessprofile';
  final String phoneNumber;

  const SetBusinessProfileScreen({super.key, required this.phoneNumber});

  @override
  State<SetBusinessProfileScreen> createState() =>
      _SetBusinessProfileScreenState();
}

class _SetBusinessProfileScreenState extends State<SetBusinessProfileScreen> {
  final GlobalKey<UploadPictureBoxState> uploadPictureKey =
      GlobalKey<UploadPictureBoxState>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> businessTypes = [
    'Restaurant',
    'Catering Service',
    'Bakery',
    'Food Truck',
    'Home Chef',
  ];

  String? selectedBusinessType;
  bool isDropdownFocused = false;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.phoneNumber;
    debugPrint('📱 Pre-filled phone number: ${_phoneController.text}');
  }

  

  @override
  void dispose() {
    _businessNameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.responsiveSize(context, 20, 40, 60);
    final vertical = Responsive.responsiveSize(context, 20, 30, 40);
    final h = Responsive.height(context);

    return BlocBuilder<BusinessProfileBloc, BusinessProfileState>(
      builder: (context, state) {
        final isLoading = state is BusinessProfileLoading;

        return LoaderOverlay(
          isLoading: isLoading,
          child: Scaffold(
            backgroundColor: AppColors.appBackground,
            appBar: NavigationbarTitle(title: 'Set Business Profile'),
            body: BlocListener<BusinessProfileBloc, BusinessProfileState>(
              listener: (context, state) {
                if (state is BusinessProfileSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Business Profile Setup Successfully!'),
                    ),
                  );

                  // Refresh provider profile after creating business profile
                  context.read<ProviderProfileBloc>().add(
                        LoadProviderProfileEvent(),
                      );

                  // Navigate to home screen
                  context.go(MyBidsScreen.path);
                } else if (state is BusinessProfileFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontal,
                  vertical: vertical,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ✅ Upload Picture
                      UploadPictureBox(
                        key: uploadPictureKey,
                        onImageChanged: (file) => _profileImage = file,
                      ),

                      SizedBox(height: h * 0.02),

                      Text(
                        'Basic Information',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize:
                              Responsive.responsiveSize(context, 16, 18, 20),
                          fontFamily: AppFonts.poppins,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: h * 0.015),

                      /// Business Type Dropdown
                      BusinessTypeDropdown(
                        selectedType: selectedBusinessType,
                        businessTypes: businessTypes,
                        isFocused: isDropdownFocused,
                        onChanged: (val) =>
                            setState(() => selectedBusinessType = val),
                        onFocusChange: (focus) =>
                            setState(() => isDropdownFocused = focus),
                      ),
                      SizedBox(height: h * 0.015),

                      /// Business Name
                      CustomTextField(
                        label: 'Business Name',
                        controller: _businessNameController,
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter business name'
                            : null,
                        capitalizeFirstLetter: true,
                      ),
                      SizedBox(height: h * 0.015),

                      /// Contact Number
                      ContactNumberField(controller: _phoneController),
                      SizedBox(height: h * 0.015),

                      /// Location
                      CustomTextField(
                        label: 'Location',
                        controller: _locationController,
                      ),
                      SizedBox(height: h * 0.015),

                      /// Map Location Field
                      const LocationField(),
                      SizedBox(height: h * 0.015),

                      /// Description
                      SpecialInstructionsField(
                        labelTextHolder: 'Description',
                        controller: _descriptionController,
                      ),
                      SizedBox(height: h * 0.025),

                      /// Submit Button
                      NextButton(
                        isLoading: false, // handled globally by LoaderOverlay
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          // ✅ Validate upload picture box explicitly
                          final imageError =
                              uploadPictureKey.currentState?.validate();
                          if (imageError != null) return;

                          if (selectedBusinessType == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a business type'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }

                          if (_profileImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please upload a picture'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }

                          final model = BusinessProfileRequestModel(
                            companyName: _businessNameController.text.trim(),
                            businessType: selectedBusinessType!,
                            description: _descriptionController.text.trim(),
                            phoneNumber: _phoneController.text.trim(),
                            lat: 37.7749, // placeholder
                            lng: -122.4194, // placeholder
                          );

                          context.read<BusinessProfileBloc>().add(
                                SubmitBusinessProfile(
                                  model,
                                  profilePicture: _profileImage,
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
