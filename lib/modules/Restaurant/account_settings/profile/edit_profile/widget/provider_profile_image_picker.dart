import 'dart:io';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/helpers/file_validation_helper.dart';
import 'package:caterbid/core/utils/helpers/image_picker_helper.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class ProviderProfileImagePicker extends StatefulWidget {
  final String? initialImage;
  final String firstLetter;
  final Function(File?) onImageChanged;

  const ProviderProfileImagePicker({
    super.key,
    this.initialImage,
    required this.firstLetter,
    required this.onImageChanged,
  });

  @override
  State<ProviderProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProviderProfileImagePicker> {
  File? _image;

  Future<void> _selectImage() async {
    final picked = await ImagePickerHelper.pickFile(context);
    if (picked == null) return;

    // Validate file before using it
    final isValid = await FileValidationHelper.validateAndShow(context, picked);
    if (!isValid) return;

    setState(() => _image = picked);
    widget.onImageChanged(_image);
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
                backgroundColor: AppColors.textDark,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : (widget.initialImage != null &&
                          widget.initialImage!.isNotEmpty)
                    ? NetworkImage(widget.initialImage!) as ImageProvider
                    : null,
                child: (_image == null && widget.initialImage == null)
                    ? Text(
                        widget.firstLetter,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: avatarRadius * 0.9,
                        ),
                      )
                    : null,
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
