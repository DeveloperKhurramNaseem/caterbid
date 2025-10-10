import 'dart:io';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/helpers/dashed_border_painter.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/helpers/image_picker_helper.dart';
import 'package:caterbid/core/utils/responsive.dart';

class UploadPictureBox extends StatefulWidget {
  const UploadPictureBox({super.key});

  @override
  State<UploadPictureBox> createState() => _UploadPictureBoxState();
}

class _UploadPictureBoxState extends State<UploadPictureBox> {
  File? _image;

  Future<void> _uploadImage() async {
    final picked = await ImagePickerHelper.pickImage(context);
    if (picked != null) setState(() => _image = picked);
  }

  @override
  Widget build(BuildContext context) {
    final height = Responsive.responsiveSize(context, 150, 180, 200);

    return GestureDetector(
      onTap: _uploadImage,
      child: DashedBorderContainer(
        color: AppColors.textDark,
        borderRadius: 8,
        dashWidth: 8,
        dashSpace: 6,
        strokeWidth: 1.5,
        child: Container(
          height: height,
          width: double.infinity,
          color: Colors.white,
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.drive_folder_upload,
                      color: Colors.teal,
                      size: Responsive.responsiveSize(context, 40, 50, 60),
                    ),
                    SizedBox(height: Responsive.responsiveSize(context, 8, 10, 12)),
                    Text(
                      'Upload Picture',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontFamily: AppFonts.nunito,
                        fontSize: Responsive.responsiveSize(context, 16, 18, 20),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _image!,
                    width: double.infinity,
                    height: height,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
