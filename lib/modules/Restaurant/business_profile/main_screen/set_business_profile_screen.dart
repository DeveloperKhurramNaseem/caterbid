import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/core/widgets/special_instructions_field.dart';
import 'package:caterbid/modules/Restaurant/business_profile/widgets/location_field.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';

// Local Widgets
// import 'package:caterbid/modules/Restaurant/business_profile/widgets/description_field.dart';
// import 'package:caterbid/modules/Restaurant/business_profile/widgets/location_field.dart';
import 'package:caterbid/modules/Restaurant/business_profile/widgets/next_button.dart';
import 'package:caterbid/modules/Restaurant/business_profile/widgets/upload_picture_box.dart';
import 'package:caterbid/modules/Restaurant/business_profile/widgets/business_type_dropdown.dart';

class SetBusinessProfileScreen extends StatefulWidget {
  static const String path = '/setbusinessprofile';
  const SetBusinessProfileScreen({super.key});

  @override
  State<SetBusinessProfileScreen> createState() =>
      _SetBusinessProfileScreenState();
}

class _SetBusinessProfileScreenState extends State<SetBusinessProfileScreen> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Dropdown-related fields
  final List<String> businessTypes = [
    'Restaurant',
    'Catering Service',
    'Bakery',
    'Food Truck',
    'Home Chef',
  ];

  String? selectedBusinessType;
  bool isDropdownFocused = false;

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

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: NavigationbarTitle(title: 'Set Business Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UploadPictureBox(),
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
            SizedBox(height: h * 0.02),

            BusinessTypeDropdown(
              selectedType: selectedBusinessType,
              businessTypes: businessTypes,
              isFocused: isDropdownFocused,
              onChanged: (val) => setState(() => selectedBusinessType = val),
              onFocusChange: (focus) =>
                  setState(() => isDropdownFocused = focus),
            ),
            SizedBox(height: h * 0.02),

            CustomTextField(
              label: 'Business Name',
              controller: _businessNameController,
            ),
            SizedBox(height: h * 0.01),

            ContactNumberField(
              controller: _phoneController,
              onChanged: (value) {
                print('Full number: $value');
              },
            ),

            SizedBox(height: h * 0.02),

            CustomTextField(label: 'Location', controller: _locationController),

            SizedBox(height: h * 0.02),

            ///  Location
            LocationField(),

            /// 🧾 Description
            SpecialInstructionsField(
              labelTextHolder: 'Description',
              controller: _descriptionController,
            ),
            SizedBox(height: h * 0.02),

            NextButton(
              onPressed: () {
                if (selectedBusinessType == null ||
                    _businessNameController.text.isEmpty ||
                    _phoneController.text.isEmpty ||
                    _locationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all required fields'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }

                // TODO: Add navigation or API call here
                debugPrint("Business Type: $selectedBusinessType");
                debugPrint("Business Name: ${_businessNameController.text}");
                debugPrint("Phone: ${_phoneController.text}");
                debugPrint("Location: ${_locationController.text}");
                debugPrint("Description: ${_descriptionController.text}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
