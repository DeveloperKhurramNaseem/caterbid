import 'dart:io';
import 'package:caterbid/core/utils/helpers/image_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _image;

  Future<void> _selectImage() async {
    final picked = await ImagePickerHelper.pickImage(context);
    if (picked != null) setState(() => _image = picked);
  }

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    final borderWidth = h * 0.005;
    final avatarRadius = h * 0.08;

    return Center(
      child: SizedBox(
        height: h * 0.2,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(borderWidth),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.icon, width: borderWidth),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : const AssetImage('assets/images/dummy_profile.jpg')
                        as ImageProvider,
              ),
            ),
            Positioned(
              bottom: -h * 0.008,
              child: GestureDetector(
                onTap: _selectImage,
                child: Container(
                  height: h * 0.055,
                  width: h * 0.055,
                  decoration: BoxDecoration(
                    color: AppColors.icon,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(h * 0.010),
                    child: Image.asset(
                      'assets/icons/image_icon.png',
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
