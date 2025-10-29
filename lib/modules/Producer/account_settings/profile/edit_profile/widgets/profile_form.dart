import 'dart:io';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/contact_number_field.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/model/requestee_profile_model.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/name_fields.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/profile_image_picker.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/save_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/bloc/requestee_profile_bloc.dart';

class ProfileForm extends StatefulWidget {
  final RequesteeModel? user;

  const ProfileForm({super.key, this.user});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;
  File? pickedImage;
  bool isSaveEnabled = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();

    if (widget.user != null) _fillControllers(widget.user!);

    firstNameController.addListener(_validateFields);
    lastNameController.addListener(_validateFields);
    phoneController.addListener(_validateFields);
  }

  void _fillControllers(RequesteeModel user) {
    final parts = (user.name ?? '').split(' ');
    firstNameController.text = parts.isNotEmpty ? parts.first : '';
    lastNameController.text = parts.length > 1
        ? parts.sublist(1).join(' ')
        : '';
    phoneController.text = user.phoneNumber ?? '';
  }

void _validateFields() {
  //  Only enable button if all required fields are filled
  final areFieldsFilled =
      firstNameController.text.trim().isNotEmpty &&
      lastNameController.text.trim().isNotEmpty &&
      phoneController.text.trim().isNotEmpty;

  setState(() => isSaveEnabled = areFieldsFilled);
}

  void _onSave() {
    context.read<RequesteeProfileBloc>().add(
      ValidateAndSaveProfileEvent(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
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
            setState(() {
              pickedImage = file;
            });
            _validateFields(); 
          },
        ),

        SizedBox(height: h * 0.05),
        NameFields(
          firstNameController: firstNameController,
          lastNameController: lastNameController,
        ),
        SizedBox(height: h * 0.02),
        ContactNumberField(controller: phoneController),
        SizedBox(height: h * 0.2),
        SaveButton(
          isEnabled: isSaveEnabled,
          isLoading:
              context.watch<RequesteeProfileBloc>().state
                  is RequesteeProfileUpdating,
          onPressed: _onSave,
        ),
      ],
    );
  }
}
