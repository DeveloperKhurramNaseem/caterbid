import 'dart:io';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/helpers/file_validation_helper.dart';
import 'package:caterbid/core/utils/helpers/image_picker_helper.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/widgets/dashed_border_painter.dart';

class UploadPictureBox extends StatefulWidget {
  final Function(File?) onImageChanged;

  const UploadPictureBox({super.key, required this.onImageChanged});

  @override
  State<UploadPictureBox> createState() => UploadPictureBoxState();
}

class UploadPictureBoxState extends State<UploadPictureBox> {
  File? image;
  bool hasError = false;

  Future<void> uploadImage() async {
    final picked = await ImagePickerHelper.pickFile(context);
    if (picked == null) return;

    final isValid = await FileValidationHelper.validateAndShow(context, picked);
    if (!isValid) return;

    setState(() {
      image = picked;
      hasError = false;
    });

    widget.onImageChanged(image);
  }

  String? validate() {
    if (image == null) {
      setState(() => hasError = true);
      return 'Please upload a picture';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final height = Responsive.responsiveSize(context, 150, 180, 200);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: uploadImage,
          child: DashedBorderContainer(
            color: hasError ? Colors.red : AppColors.textDark,
            borderRadius: 8,
            dashWidth: 8,
            dashSpace: 6,
            strokeWidth: 1.5,
            child: Container(
              height: height,
              width: double.infinity,
              color: Colors.white,
              child: image == null
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
                        image!,
                        width: double.infinity,
                        height: height,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              'Please upload a picture',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
