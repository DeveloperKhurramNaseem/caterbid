import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/special_instructions_field.dart';
import 'package:caterbid/modules/Restaurant/business_profile/model/business_profile_request_model.dart';
import 'package:caterbid/modules/Restaurant/business_profile/bloc/business_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/business_type_dropdown.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/location_field.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/next_button.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/upload_picture_box.dart';

class BusinessForm extends StatefulWidget {
  final String phoneNumber;
  const BusinessForm({super.key, required this.phoneNumber});

  @override
  State<BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final uploadKey = GlobalKey<UploadPictureBoxState>();

  String? selectedBusinessType;
  File? _profileImage;
  bool isDropdownFocused = false;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    final horizontal = Responsive.responsiveSize(context, 20, 40, 60);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: h * 0.02),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UploadPictureBox(
              key: uploadKey,
              onImageChanged: (file) => _profileImage = file,
            ),
            SizedBox(height: h * 0.02),
            Text(
              'Basic Information',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Responsive.responsiveSize(context, 16, 18, 20),
                fontFamily: AppFonts.poppins,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: h * 0.015),
            BusinessTypeDropdown(
              selectedType: selectedBusinessType,
              businessTypes: const [
                'Restaurant',
                'Catering Service',
                'Bakery',
                'Food Truck',
                'Home Chef',
              ],
              isFocused: isDropdownFocused,
              onChanged: (val) => setState(() => selectedBusinessType = val),
              onFocusChange: (focus) =>
                  setState(() => isDropdownFocused = focus),
            ),
            SizedBox(height: h * 0.015),
            CustomTextField(
              label: 'Business Name',
              controller: _businessNameController,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Enter business name' : null,
            ),
            SizedBox(height: h * 0.015),
            ContactNumberField(controller: _phoneController),
            SizedBox(height: h * 0.015),
            CustomTextField(label: 'Location', controller: _locationController),
            SizedBox(height: h * 0.015),
            const LocationField(),
            SizedBox(height: h * 0.015),
            SpecialInstructionsField(
              labelTextHolder: 'Description',
              controller: _descriptionController,
            ),
            SizedBox(height: h * 0.025),
            NextButton(
              isLoading: false,
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                if (selectedBusinessType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a business type'),
                    ),
                  );
                  return;
                }

                final model = BusinessProfileRequestModel(
                  companyName: _businessNameController.text.trim(),
                  businessType: selectedBusinessType!,
                  description: _descriptionController.text.trim(),
                  phoneNumber: _phoneController.text.trim(),
                  lat: 37.7749,
                  lng: -122.4194,
                );

                context.read<BusinessProfileBloc>().add(
                  SubmitBusinessProfile(model, profilePicture: _profileImage),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
